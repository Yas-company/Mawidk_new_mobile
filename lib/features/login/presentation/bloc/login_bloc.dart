import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:mawidak/core/base_network/error/handler/error_model.dart';
import 'package:mawidak/core/base_network/general_response_model.dart';
import 'package:mawidak/core/component/custom_toast/p_toast.dart';
import 'package:mawidak/core/data/constants/app_router.dart';
import 'package:mawidak/core/extensions/string_extensions.dart';
import 'package:mawidak/core/global/enums/global_enum.dart';
import 'package:mawidak/core/global/global_func.dart';
import 'package:mawidak/core/global/state/base_state.dart';
import 'package:mawidak/di.dart';
import 'package:mawidak/features/login/data/model/loction_request_model.dart';
import 'package:mawidak/features/login/data/model/login_response_model.dart';
import 'package:mawidak/features/login/data/repository/login_repository_impl.dart';
import 'package:mawidak/features/login/domain/use_case/login_use_case.dart';
import 'package:mawidak/features/login/presentation/bloc/login_event.dart';
import 'package:mawidak/features/survey/presentation/bloc/survey_bloc.dart';
import 'package:mawidak/features/survey/presentation/bloc/survey_event.dart';
import '../../../../core/data/constants/global_obj.dart';
import '../../../../core/data/constants/shared_preferences_constants.dart';
import '../../../../core/services/local_storage/secure_storage/secure_storage_service.dart';
import '../../../../core/services/local_storage/shared_preference/shared_preference_service.dart';



class LoginBloc extends Bloc<LoginEvent, BaseState> {
  final LoginUseCase loginUseCase;
  bool isChecked = false;
  LocationRequestModel? locationRequestModel;
  TextEditingController phone = TextEditingController();
  TextEditingController password =  TextEditingController();


  LoginBloc({required this.loginUseCase}) : super(ButtonDisabledState()) {
    on<NormalLoginEvent>(onNormalLogin);
    on<LoginValidationEvent>(onValidateAllFields);
  }

  void onValidateAllFields(LoginValidationEvent event, Emitter emit) {
    final isPhoneValid = !phone.text.isEmptyOrNull && isValidSaudiPhoneNumber(phone.text);
    if (isPhoneValid && !phone.text.isEmptyOrNull && !password.text.isEmptyOrNull && password.text.length <= 50
    &&isChecked) {
      emit(ButtonEnabledState());
    } else {
      emit(ButtonDisabledState());
    }
  }


  Future<void> onNormalLogin(NormalLoginEvent event, Emitter emit) async {
    emit(const ButtonLoadingState());
    // String deviceID = await DeviceInfoManager.getDeviceIdentity();
    // event.loginRequestModel.deviceID = deviceID;
    event.loginRequestModel.type = isDoctor()?UserType.doctor.index
        :UserType.patient.index;
    final response = await loginUseCase.login(event.loginRequestModel,);
    await response.fold(
          (l) async {emit(ErrorState(l));},
          (r) async {
        if ((r).statusCode == 200 || (r).statusCode == 201) {
          await SecureStorageService().clear();
          await SecureStorageService().write(key: SharPrefConstants.phone,
              value: event.loginRequestModel.phone ?? '');
          await SecureStorageService().write(
              key: SharPrefConstants.passwordKey,
              value: event.loginRequestModel.password ?? '');

          if((r as GeneralResponseModel).model!=null){
            if(((r).model as LoginResponseModel).model?.isVerified??false){
              await SharedPreferenceService().setString(
                   SharPrefConstants.profileCompletionPercentage,
                  (((r).model as LoginResponseModel).model?.profileCompletionPercentage ?? 0).toString());
              await SecureStorageService().write(
                  key: SharPrefConstants.accessToken,
                  value:((r).model as LoginResponseModel)
                      .model?.accessToken ?? 'accessToken');
              await SecureStorageService().write(
                  key: SharPrefConstants.refreshToken,
                  value:((r).model as LoginResponseModel)
                      .model?.refreshToken ?? 'refreshToken');
              await SharedPreferenceService().setBool(SharPrefConstants.surveyStatus,
                  ((r).model as LoginResponseModel).model?.surveyStatus ?? true);
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
              // bool isDoctor = SharedPreferenceService().getBool(SharPrefConstants.isDoctor);
              bool isSKippedSurvey = SharedPreferenceService().getBool(SharPrefConstants.isSKippedSurvey);
              if(!isDoctor() && isSKippedSurvey){
                Get.context!.goNamed(isDoctor()?AppRouter.homeDoctor:AppRouter.homePatient);
                return;
              }

              if(locationRequestModel!=null){
                await LoginUseCase(loginRepository:getIt()).updateLocation(locationRequestModel!);
              }
              if((((r).model as LoginResponseModel).model?.surveyStatus ?? false)){
                // goToSurveyScreen(isDoctor?UserType.doctor:UserType.patient,event.surveyBloc);
                goToSurveyScreen(isDoctor()?UserType.doctor:UserType.patient);
              }else{
                if(isDoctor()){
                  await getDoctorProfileStatus();
                }
                Get.context!.goNamed(isDoctor()?AppRouter.homeDoctor:AppRouter.homePatient);
                // goToSurveyScreen(isDoctor()?UserType.doctor:UserType.patient);
              }
              // // Get.context!.goNamed(AppRouter.home);
              // Get.context!.goNamed(AppRouter.doctorOrPatientScreen);
            }else{
              Get.context!.push(AppRouter.verifyOtp,
                extra: {
                  'phone':event.loginRequestModel.phone,
                  'isLogin': true,
                },
                // extra:event.loginRequestModel.phone
              );
            }
          }else{
            Get.context!.push(AppRouter.verifyOtp,
              extra: {
                'phone':event.loginRequestModel.phone,
                'isLogin': true,
              },
              // extra:event.loginRequestModel.phone
            );
          }
          // Get.context!.goNamed(AppRouter.patientSurvey);
        } else {
          handleError(errors: r.errors ?? [], statusCode: r.statusCode ?? 0);
        }
        emit(LoadedState(r));
      },
    );
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

  Future<void> allowLocation() async {
    dynamic res = await getCurrentLocation();
    if(res is LocationRequestModel){
      locationRequestModel = res;
      print('resss>>'+jsonEncode(res));
    }
  }
}


Future<dynamic> getCurrentLocation() async {
  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  LocationPermission permission = await Geolocator.checkPermission();

  if (!serviceEnabled) {
    await Geolocator.openLocationSettings();
    return;
  }
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
  }
  if (permission == LocationPermission.deniedForever ||
      permission == LocationPermission.denied) {
    SafeToast.show(message:'Location permissions are denied',type:MessageType.error);
    return;
  }

  Position position = await Geolocator.getCurrentPosition();
  return LocationRequestModel(latitude: position.latitude, longitude:position.longitude);
}