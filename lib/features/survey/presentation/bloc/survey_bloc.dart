import 'dart:convert';
import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
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
import 'package:mawidak/features/survey/data/model/survey_doctor_request_model.dart';
import 'package:mawidak/features/survey/data/model/survey_response_model.dart';
import 'package:mawidak/features/survey/data/model/survey_submit_request_model.dart';
import 'package:mawidak/features/survey/domain/use_case/survey_use_case.dart';
import 'package:mawidak/features/survey/presentation/bloc/survey_event.dart';
import 'package:mawidak/features/survey/presentation/ui/widgets/doctor_widgets/information_completed_widget.dart';



class SurveyBloc extends Bloc<SurveyEvent, BaseState> {
  final SurveyUseCase surveyUseCase;
  List<ScreenModel> surveyList = [];
  int index = 0;

  SurveyBloc({required this.surveyUseCase}) : super(ButtonDisabledState()) {
    on<GetSurveyEvent>(onGetSurveyEvent);
    on<NextPageEvent>(_onNextPage);
    on<PrevPageEvent>(_onPrevPage);
    on<ValidateSurveyEvent>(_onValidateSurvey);
    on<SubmitSurveyEvent>(onSubmitSurveyEvent);
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
  }

  bool validateCurrentPage() {
    final currentQuestions = surveyList[index].questions ?? [];
    for (final question in currentQuestions) {
      if (question.isRequired != true) continue;
      final type = question.type ?? '';
      if (question.answer == null ||
          (type.contains('multi') && (question.answer as List).isEmpty) ||
          ((type == 'text' || type == 'radio_button' || type == 'number' ||
              type == 'sate' || type == 'textarea') &&
              (question.answer ?? '').isEmpty) ||
          (type == 'tag' && (question.isTrue == null || (question.isTrue == true &&
                      (question.answer == null || (question.answer as List).isEmpty))
          ))
      ) {
        return false;
      }
    }
    return true;
  }


  Future<void> onSubmitSurveyEvent(SubmitSurveyEvent event, Emitter<BaseState> emit) async {
    log('message>'+jsonEncode(event.model));
    loadDialog();
    emit(const ButtonLoadingState());
    final response = await surveyUseCase.submitSurvey(model: event.model);
    hideLoadingDialog();
    await response.fold((l) async {
      emit(ErrorState(l));
    }, (r) async {
      emit(LoadedState(r));
      if ((r).statusCode == 200 || (r).statusCode == 201) {
        await SharedPreferenceService().setBool(SharPrefConstants.surveyStatus,false);
        String name = SharedPreferenceService().getString(SharPrefConstants.userName);
        showDialog(context:Get.context!,
          builder: (BuildContext context) {
            return Dialog(insetPadding:EdgeInsets.symmetric(horizontal:20),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: InformationCompletedWidget(
                  title:'$name${'thank_you'.tr()}',
                  image:AppSvgIcons.patientSuccess,
                ));
          },
        );
        // SafeToast.show(message: 'تم إرسال الاستبيان بنجاح');
        // Navigator.pop(Get.context!);
        // Get.context!.go(AppRouter.home);
      } else {
        // handleError(errors: r.errors ?? [], statusCode: r.statusCode ?? 0);
      }
    });
  }
  void submitSurvey() {
    bool isDoctor = SharedPreferenceService().getBool(SharPrefConstants.isDoctor);
    if(isDoctor){
      // SurveySubmitRequestModel answers =  generateSurveySubmitRequest(surveyList);
      // SurveyDoctorRequestModel surveyDoctorRequestModel = SurveyDoctorRequestModel(
      //     type:3, answers: answers.answers??[],
      //     certificates:[], certificateNames:[]);
      // add(SubmitSurveyDoctorEvent(model:surveyDoctorRequestModel));
    }else{
      add(SubmitSurveyEvent(model: generateSurveySubmitRequest(surveyList)));
    }
  }


  Future<void> onSubmitSurveyDoctorEvent(SubmitSurveyDoctorEvent event, Emitter<BaseState> emit) async {
    log('message>'+jsonEncode(event.model));
    loadDialog();
    emit(const ButtonLoadingState());
    final response = await surveyUseCase.submitSurveyDoctor(model: event.model);
    hideLoadingDialog();
    await response.fold((l) async {
      emit(ErrorState(l));
    }, (r) async {
      emit(LoadedState(r));
      if ((r).statusCode == 200 || (r).statusCode == 201) {
        await SharedPreferenceService().setBool(SharPrefConstants.surveyStatus,false);
        String name = SharedPreferenceService().getString(SharPrefConstants.userName);
        showDialog(context:Get.context!,
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
        } else if (question.type == 'multi_select') {
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



