import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mawidak/core/base_network/error/handler/error_model.dart';
import 'package:mawidak/core/base_network/general_response_model.dart';
import 'package:mawidak/core/component/custom_toast/p_toast.dart';
import 'package:mawidak/core/data/constants/app_router.dart';
import 'package:mawidak/core/data/constants/shared_preferences_constants.dart';
import 'package:mawidak/core/extensions/string_extensions.dart';
import 'package:mawidak/core/global/enums/global_enum.dart';
import 'package:mawidak/core/global/global_func.dart';
import 'package:mawidak/core/global/state/base_state.dart';
import 'package:mawidak/core/services/local_storage/secure_storage/secure_storage_service.dart';
import 'package:mawidak/core/services/local_storage/shared_preference/shared_preference_service.dart';
import 'package:mawidak/di.dart';
import 'package:mawidak/features/login/data/model/login_response_model.dart';
import 'package:mawidak/features/login/domain/use_case/login_use_case.dart';
import 'package:mawidak/features/survey/presentation/bloc/survey_bloc.dart';
import 'package:mawidak/features/survey/presentation/bloc/survey_event.dart';
import 'package:mawidak/features/verify_otp/domain/use_case/verify_otp_use_case.dart';
import 'package:mawidak/features/verify_otp/presentation/bloc/verify_otp_event.dart';
import '../../../../core/data/constants/global_obj.dart';

class VerifyOtpBloc extends Bloc<VerifyOtpEvent,BaseState> {
  final VerifyOtpUseCase verifyOtpUseCase;
  TextEditingController otp = TextEditingController();
  VerifyOtpBloc({required this.verifyOtpUseCase}) : super(ButtonDisabledState()) {
    on<ApplyVerifyOtpEvent>(verifyOtp);
    on<ValidationEvent>(onValidateAllFields);
    on<ReSendOtpEvent>(onReSendOtpEvent);
  }

  void onValidateAllFields(ValidationEvent event, Emitter emit) {
    otp.text = event.code;
    if (!event.code.isEmptyOrNull && event.code.length == 4) {
      emit(ButtonEnabledState());
    } else {
      emit(ButtonDisabledState());
    }
  }

  Future<void> verifyOtp(ApplyVerifyOtpEvent event, Emitter emit) async {
    emit(const ButtonLoadingState());
    final response = await verifyOtpUseCase.verifyOtp(event.verifyOtpRequestModel,
    event.isLogin);
    await response.fold((l) async {emit(ErrorState(l));}, (r) async {
        if ((r).statusCode == 200 || (r).statusCode == 201) {
          if((r as GeneralResponseModel).model!=null){
            await SecureStorageService().write(
                key: SharPrefConstants.accessToken,
                value:((r).model as LoginResponseModel)
                    .model?.accessToken ?? 'accessToken');
            await SecureStorageService().write(
                key: SharPrefConstants.refreshToken,
                value:((r).model as LoginResponseModel)
                    .model?.refreshToken ?? 'refreshToken');
            await SharedPreferenceService().setBool(SharPrefConstants.isLoginKey, true);
            await SharedPreferenceService().setString(SharPrefConstants.userName,
                ((r).model as LoginResponseModel)
                    .model?.name ?? '');
            await SharedPreferenceService().setInt(SharPrefConstants.userId,
                ((r).model as LoginResponseModel)
                    .model?.id ?? 0);
            await SharedPreferenceService().setString(SharPrefConstants.phone,
                ((r).model as LoginResponseModel)
                    .model?.phone ?? '');
            await SharedPreferenceService().setString(
                SharPrefConstants.profileCompletionPercentage,
                (((r).model as LoginResponseModel).model?.profileCompletionPercentage ?? 0).toString());
            // print('ttt>>'+(((r).model as LoginResponseModel).model?.surveyStatus ?? false).toString());
            // bool isDoctor = SharedPreferenceService().getBool(SharPrefConstants.isDoctor);
            bool isSKippedSurvey = SharedPreferenceService().getBool(SharPrefConstants.isSKippedSurvey);

            if(!isDoctor() && isSKippedSurvey){
              if(isDoctor()){
                await getDoctorProfileStatus();
              }
              Get.context!.goNamed(isDoctor()?AppRouter.homeDoctor:AppRouter.homePatient);
              return;
            }
            if((((r).model as LoginResponseModel).model?.surveyStatus ?? false)){
              // goToSurveyScreen(isDoctor?UserType.doctor:UserType.patient,event.surveyBloc);
              goToSurveyScreen(isDoctor()?UserType.doctor:UserType.patient);
            }else{
              if(isDoctor()){
                await getDoctorProfileStatus();
              }
              Get.context!.goNamed(isDoctor()?AppRouter.homeDoctor:AppRouter.homePatient);
            }
            // // Get.context!.goNamed(AppRouter.home);
            // Get.context!.goNamed(AppRouter.doctorOrPatientScreen);
          }else{
            Get.context!.push(AppRouter.confirmPassword,extra:event.verifyOtpRequestModel.phone??'');
          }
        } else {
          handleError(errors: r.errors ?? [], statusCode: r.statusCode ?? 0);
        }
        emit(LoadedState(r));
      },
    );
  }


  Future<void> onReSendOtpEvent(ReSendOtpEvent event, Emitter emit) async {
    emit(LoadingState());
    event.loginRequestModel.type = isDoctor()?UserType.doctor.index
        :UserType.patient.index;
    final response = await LoginUseCase(loginRepository:getIt()).login(event.loginRequestModel,);
    await response.fold((l) async {emit(ErrorState(l));},
          (r) async {emit(FormLoadedState(r,));
      },
    );
  }

}

// void goToSurveyScreen(UserType type,SurveyBloc surveyBloc) async {
void goToSurveyScreen(UserType type) async {
  bool isDoctor = SharedPreferenceService().getBool(SharPrefConstants.isDoctor);
  // surveyBloc = SurveyBloc(surveyUseCase: getIt());
  // loadDialog();
  // surveyBloc.add(GetSurveyEvent(type:type));
  // final state = await surveyBloc.stream.firstWhere(
  //       (state) => state is LoadedState || state is ErrorState,
  // );
  // hideLoadingDialog();
  // if (state is LoadedState) {
  //   if (surveyBloc.surveyList.isNotEmpty) {
      if (!isDoctor) {
        // مريض
        // Get.context!.push(AppRouter.patientSurvey,extra: surveyBloc);
        Get.context!.push(AppRouter.patientSurvey);
      } else if (isDoctor) {
        // دكتور
        // Get.context!.push(AppRouter.doctorSurvey,extra: surveyBloc);
        Get.context!.push(AppRouter.doctorSurvey);
      }
    // } else {
    //   SafeToast.show(
    //     message: 'لا يوجد استبيانات متاحة حالياً.',
    //     type: MessageType.warning,
    //   );
    // }
  // } else if (state is ErrorState) {
  //   SafeToast.show(
  //     message: 'فشل تحميل الاستبيان.',
  //     type: MessageType.error,
  //   );
  // }
}
