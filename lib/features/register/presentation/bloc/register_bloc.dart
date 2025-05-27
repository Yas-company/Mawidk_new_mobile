import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mawidak/core/base_network/error/handler/error_model.dart';
import 'package:mawidak/core/data/constants/app_router.dart';
import 'package:mawidak/core/extensions/string_extensions.dart';
import 'package:mawidak/core/global/enums/global_enum.dart';
import 'package:mawidak/core/global/global_func.dart';
import 'package:mawidak/core/global/state/base_state.dart';
import 'package:mawidak/features/register/domain/use_case/register_use_case.dart';
import 'package:mawidak/features/register/presentation/bloc/register_event.dart';
import '../../../../core/data/constants/global_obj.dart';
import '../../../../core/data/constants/shared_preferences_constants.dart';
import '../../../../core/services/local_storage/secure_storage/secure_storage_service.dart';
import '../../../../core/services/local_storage/shared_preference/shared_preference_service.dart';



class RegisterBloc extends Bloc<RegisterEvent, BaseState> {
  final RegisterUseCase registerUseCase;
  TextEditingController phone = TextEditingController();
  TextEditingController name =  TextEditingController();
  TextEditingController password =  TextEditingController();
  TextEditingController confirmPassword =  TextEditingController();
  TextEditingController email =  TextEditingController();

  RegisterBloc({required this.registerUseCase}) : super(ButtonDisabledState()) {
    on<AddRegisterEvent>(onNormalLogin);
    on<ValidationEvent>(onValidateAllFields);
  }

  void onValidateAllFields(ValidationEvent event, Emitter emit) {
    final isPhoneValid = !phone.text.isEmptyOrNull && isValidSaudiPhoneNumber(phone.text);
    final isPasswordValid = !password.text.isEmptyOrNull && password.text.length <= 50;
    final isConfirmPasswordValid = password.text == confirmPassword.text;

    final isEmailValid = email.text.isEmpty || RegExp(
        r"^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$"
    ).hasMatch(email.text); // email is either empty or a valid format

    final isNameValid = name.text.isEmpty || name.text.length <= 50; // name is either empty or <= 50 chars

    if (isPhoneValid &&
        isPasswordValid &&
        isConfirmPasswordValid &&
        isEmailValid &&
        isNameValid) {
      emit(ButtonEnabledState());
    } else {
      emit(ButtonDisabledState());
    }
  }



  Future<void> onNormalLogin(AddRegisterEvent event, Emitter emit) async {
    emit(const ButtonLoadingState());
    bool isDoctor = SharedPreferenceService().getBool(SharPrefConstants.isDoctor);
    event.registerRequestModel.type = isDoctor? UserType.doctor.index:UserType.patient.index;
    log('message>>'+jsonEncode(event.registerRequestModel));
    final response = await registerUseCase.register(event.registerRequestModel,);
    await response.fold(
      (l) async {emit(ErrorState(l));},
      (r) async {
        if ((r).statusCode == 200 || (r).statusCode == 201) {
          await SecureStorageService().clear();
          await SecureStorageService().write(
              key: SharPrefConstants.emailKey,
              value: event.registerRequestModel.name ?? '');
          await SecureStorageService().write(
              key: SharPrefConstants.passwordKey,
              value: event.registerRequestModel.password ?? '');
          await SharedPreferenceService().setBool(SharPrefConstants.isSKippedSurvey,false);
          // await SharedPreferenceService().setBool(SharPrefConstants.isLoginKey, true);
          // await SecureStorageService().write(
          //   key: SharPrefConstants.userLoginTokenKey,
          //   value: ((r as GeneralResponseModel).model as RegisterResponseModel)
          //           .model
          //           ?.token ??
          //       'token',
          // );
          // await SecureStorageService().write(
          //   key: SharPrefConstants.userRefreshTokenKey,
          //   value: ((r).model as LoginResponseModel).model?.refershToken ?? 'refershToken',
          // );
          Get.context!.push(AppRouter.login);
        } else {
          handleError(errors: r.errors ?? [], statusCode: r.statusCode ?? 0);
        }
        emit(LoadedState(r));
      },
    );
  }
}
