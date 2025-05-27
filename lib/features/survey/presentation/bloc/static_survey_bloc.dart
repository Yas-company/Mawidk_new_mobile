import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mawidak/core/base_network/general_response_model.dart';
import 'package:mawidak/core/component/custom_toast/p_toast.dart';
import 'package:mawidak/core/data/assets_helper/app_svg_icon.dart';
import 'package:mawidak/core/data/constants/app_router.dart';
import 'package:mawidak/core/data/constants/global_obj.dart';
import 'package:mawidak/core/data/constants/shared_preferences_constants.dart';
import 'package:mawidak/core/global/enums/global_enum.dart';
import 'package:mawidak/core/global/global_func.dart';
import 'package:mawidak/core/global/state/base_state.dart';
import 'package:mawidak/core/services/local_storage/shared_preference/shared_preference_service.dart';
import 'package:mawidak/features/survey/data/model/patient_survey_request_model.dart';
import 'package:mawidak/features/survey/data/model/survey_doctor_request_model.dart';
import 'package:mawidak/features/survey/data/model/survey_response_model.dart';
import 'package:mawidak/features/survey/data/model/survey_submit_request_model.dart';
import 'package:mawidak/features/survey/domain/use_case/survey_use_case.dart';
import 'package:mawidak/features/survey/presentation/bloc/survey_event.dart';
import 'package:mawidak/features/survey/presentation/ui/widgets/doctor_widgets/information_completed_widget.dart';
import 'package:path/path.dart';



class StaticSurveyBloc extends Bloc<SurveyEvent, BaseState> {
  final SurveyUseCase surveyUseCase;
  List<ScreenModel> surveyList = [];
  List<File> selectedFiles = [];
  int index = 0;

  StaticSurveyBloc({required this.surveyUseCase}) : super(ButtonDisabledState()) {
    on<GetSurveyEvent>(onGetSurveyEvent);
    on<NextPageEvent>(_onNextPage);
    on<PrevPageEvent>(_onPrevPage);
    on<ValidateSurveyEvent>(_onValidateSurvey);
    on<SubmitPatientSurveyEvent>(onSubmitPatientSurveyEvent);
    on<SubmitSurveyDoctorEvent>(onSubmitSurveyDoctorEvent);
    on<FillSelectedFilesEvent>(onFillSelectedFilesEvent);
  }

  Future<void> onGetSurveyEvent(GetSurveyEvent event, Emitter<BaseState> emit) async {
    emit(const ButtonLoadingState());
    final response = await surveyUseCase.getSurvey(type:event.type);
    await response.fold((l) async {
      emit(ErrorState(l));
    }, (r) async {
      surveyList = ((r as GeneralResponseModel).model as SurveyModel).model?.screens ?? [];
      emit(LoadedState(r));
    });
  }

  void _onNextPage(NextPageEvent event, Emitter<BaseState> emit) {
    if (index < surveyList.length - 1) {
      index++;
      event.controller.animateToPage(
        index,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
      add(ValidateSurveyEvent());
    } else {
      submitSurvey();
    }
    emit(LoadedState(''));
  }

  void _onPrevPage(PrevPageEvent event, Emitter<BaseState> emit) {
    if (index > 0) {
      index--;
      event.controller.animateToPage(
        index,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
      add(ValidateSurveyEvent());
    }
    emit(LoadedState(''));
  }

  void _onValidateSurvey(ValidateSurveyEvent event, Emitter<BaseState> emit) {
    if (validateCurrentPage()) {
      emit(ButtonEnabledState());
    } else {
      emit(ButtonDisabledState());
    }
    add(FillSelectedFilesEvent(files: selectedFiles));
  }


  bool validateCurrentPage() {
    final currentQuestions = surveyList[index].questions ?? [];
    for (final question in currentQuestions) {
      if (question.isRequired != true) continue;
      final type = question.type ?? '';
      if (question.answer == null ||
          ((type=='multi_select'||type=='drop_down') && (question.answer as List).isEmpty) ||
          ((type == 'text' || type == 'number' ||
              type == 'sate' || type == 'textarea') &&
              (question.answer ?? '').isEmpty) ||
          ((type == 'radio_button'||type=='multi_select_doctor') && (question.answer == null)) ||
          ((type == 'tag'||type=='tapped_text_field') && (question.isTrue == null || (question.isTrue == true &&
              (question.answer == null || (question.answer as List).isEmpty))))
      ) {
        if(((type == 'tag'||type=='tapped_text_field') && (question.isTrue != null && (question.isTrue == false)))){
          return true;
        }
        return false;
      }
    }
    return true;
  }


  Future<void> onSubmitPatientSurveyEvent(SubmitPatientSurveyEvent event, Emitter<BaseState> emit) async {
    // log('messagemmm>'+jsonEncode(event.model));
    loadDialog();
    // SafeToast.show(message: 'message');
    // emit(const ButtonLoadingState());
    final response = await surveyUseCase.submitPatientSurvey(model: event.model);
    hideLoadingDialog();
    await response.fold((l) async {
      emit(ErrorState(l));
    }, (r) async {
      emit(LoadedState(r));
      if ((r).statusCode == 200 || (r).statusCode == 201) {
        await SharedPreferenceService().setBool(SharPrefConstants.surveyStatus,false);
        String name = SharedPreferenceService().getString(SharPrefConstants.userName);
        showDialog(context:Get.context!,barrierDismissible:false,
          builder: (BuildContext context) {
            return Dialog(insetPadding:EdgeInsets.symmetric(horizontal:20),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: InformationCompletedWidget(
                  title:'$nameشكرًا لك يا ',
                  image:AppSvgIcons.patientSuccess,
                ));
          },
        );
      } else {
      }
    });
  }

  void submitSurvey() {
    bool isDoctor = SharedPreferenceService().getBool(SharPrefConstants.isDoctor);
    if(isDoctor){
      SurveyDoctorRequestModel model = SurveyDoctorRequestModel(
          gender:(surveyList[0].questions?[0].answer??Option(id: 0)).id,
          // specializationId:(surveyList[0].questions?[1].answer??Option(id: 0)).id,
          specializationId:((surveyList[0].questions?[1].answer)??[]).first.id,
          experience:(surveyList[1].questions?[0].answer??Option(id: 0)).id,
          licenseNumber:int.parse(surveyList[1].questions?[1].answer??'0'),
        certificates: selectedFiles,
        certificateNames: selectedFiles.map((file) => basename(file.path)).toList()
    );
      // log('modelIS>>>>'+jsonEncode(model));
      add(SubmitSurveyDoctorEvent(model:model));
    }else{
      // add(SubmitSurveyEvent(model: generateSurveySubmitRequest(surveyList)));
      // jsonEncode('modelIs>>'+jsonEncode(generatePatientSurvey(surveyList)));
      add(SubmitPatientSurveyEvent(model: generatePatientSurvey(surveyList)));
    }
  }


  Future<void> onSubmitSurveyDoctorEvent(SubmitSurveyDoctorEvent event, Emitter<BaseState> emit) async {
    log('message>'+jsonEncode(event.model));
    loadDialog();
    // await Future.delayed(Duration(seconds:3));
    final response = await surveyUseCase.submitSurveyDoctor(model:event.model);
    hideLoadingDialog();
    response.fold((l) async {emit(ErrorState(l));
    }, (r) async {
      emit(LoadedState(r));
      if ((r).statusCode == 200 || (r).statusCode == 201) {
        await SharedPreferenceService().setBool(SharPrefConstants.surveyStatus,false);
        // String name = SharedPreferenceService().getString(SharPrefConstants.userName);
        showDialog(context:Get.context!,
          barrierDismissible:false,
          builder: (BuildContext context) {
            return Dialog(
                insetPadding:EdgeInsets.symmetric(horizontal:20),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: InformationCompletedWidget(height:98,
                  title:'! تم إكمال بياناتك ',
                  subTitle:'شكراً لك!  سنراجع بياناتك ونقوم بإبلاغك قريباً.',
                  image:AppSvgIcons.successIcon,
                ));
          },
        );
      } else {
      }
    });
  }


  Future<void> onFillSelectedFilesEvent(FillSelectedFilesEvent event, Emitter<BaseState> emit) async {
    selectedFiles = event.files;
    emit(SurveyUpdatedState(selectedFiles: List.from(selectedFiles)));
  }

}


PatientSurveyRequestModel generatePatientSurvey(List<ScreenModel> surveyList) {
  // bool isDoctor = SharedPreferenceService().getBool(SharPrefConstants.isDoctor);
  // print('kk>>'+(surveyList[2].questions?[0].answer??[]).toString());
  return PatientSurveyRequestModel(
      gender:(surveyList[0].questions?[0].answer??Option(id: 0)).id,
      age:int.parse(surveyList[0].questions?[1].answer??'0'),
      weight:int.parse(surveyList[0].questions?[2].answer??'0'),
      height:int.parse(surveyList[0].questions?[3].answer??'0'),
      generalHealth:(surveyList[1].questions?[0].answer??Option(id: 0)).id,
    chronicDiseaseIds:List<Option>.from(surveyList[2].questions?[0].answer ?? []).map((e) => e.id!).toList(),
    dailyMedications:(surveyList[3].questions?[0].answer??[]),
    allergies:(surveyList[3].questions?[1].answer??[]),
    infectiousDiseases:(surveyList[3].questions?[2].answer??[]),
    exerciseFrequency:(surveyList[4].questions?[0].answer??Option(id: 0)).id,
    smokingStatus:((surveyList[5].questions?[0].answer??Option(id: 0)).id)==1?1:0,
    sleepProblems:((surveyList[5].questions?[1].answer??Option(id: 0)).id)==1?true:false,
    familyDiseases:(surveyList[6].questions?[0].answer??[]),
    seriousHealthIssues:(surveyList[6].questions?[1].answer??[]),
    medicalCheckups:(surveyList[6].questions?[2].answer??[]),
    consultationPreference:(surveyList[7].questions?[0].answer??Option(id: 0)).id,
    doctorLocationPreference:(surveyList[7].questions?[1].answer??Option(id: 0)).id,
    wantsNotifications: ((surveyList[7].questions?[2].answer??Option(id: 0)).id)==1?true:false,
    wantsFollowUp: ((surveyList[7].questions?[3].answer??Option(id: 0)).id)==1?true:false,
  );
}


SurveySubmitRequestModel generateSurveySubmitRequest(List<ScreenModel> surveyList) {
  List<SurveySubmitAnswers> allAnswers = [];

  for (var screen in surveyList) {
    for (var question in screen.questions??[]) {
      if (question.answer != null) {
        if (question.type == 'text' ||
            question.type == 'textarea' ||
            question.type == 'number' ||
            question.type == 'sate') {
          allAnswers.add(SurveySubmitAnswers(
            questionId: question.id,
            answer: question.answer as String,
          ));
        } else if (question.type == 'single_choice' ||
            question.type == 'radio' ||
            question.type == 'yes_no') {
          allAnswers.add(SurveySubmitAnswers(
            questionId: question.id,
            optionId: (question.answer as Option).id??0,
          ));
        } else if (question.type == 'multi_select'||question.type == 'drop_down') {
          List<Option> options = (question.answer as List)
              .map((item) => item as Option)
              .toList();
          allAnswers.add(SurveySubmitAnswers(
            questionId: question.id,
            optionIds: options.map((option) => option.id??0).toList(),
          ));
        }else if (question.type == 'tag') {
          allAnswers.add(SurveySubmitAnswers(
            questionId: int.parse(question.logicRules?.first.questionId??'10'),
            tags: question.answer ,
          ));
        }
      }
    }
  }
  bool isDoctor = SharedPreferenceService().getBool(SharPrefConstants.isDoctor);
  return SurveySubmitRequestModel(
    type: isDoctor? UserType.doctor.index:UserType.patient.index,
    answers: allAnswers,
  );
}



