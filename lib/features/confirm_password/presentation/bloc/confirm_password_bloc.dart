import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mawidak/core/base_network/error/handler/error_model.dart';
import 'package:mawidak/core/data/constants/app_router.dart';
import 'package:mawidak/core/extensions/string_extensions.dart';
import 'package:mawidak/core/global/state/base_state.dart';
import 'package:mawidak/features/confirm_password/domain/use_case/confirm_password_use_case.dart';
import 'package:mawidak/features/confirm_password/presentation/bloc/confirm_password_event.dart';
import '../../../../core/data/constants/global_obj.dart';




class ConfirmPasswordBloc extends Bloc<ConfirmPasswordEvent, BaseState> {
  final ConfirmPasswordUseCase confirmPasswordUseCase;
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword =  TextEditingController();


  ConfirmPasswordBloc({required this.confirmPasswordUseCase}) : super(ButtonDisabledState()) {
    on<ApplyConfirmPasswordEvent>(onNormalLogin);
    on<ValidationEvent>(onValidateAllFields);
  }

  void onValidateAllFields(ValidationEvent event, Emitter emit) {
    if (!password.text.isEmptyOrNull && !confirmPassword.text.isEmptyOrNull &&
        password.text.length <= 50 && confirmPassword.text.length <= 50 &&
        password.text==confirmPassword.text) {
      emit(ButtonEnabledState());
    } else {
      emit(ButtonDisabledState());
    }
  }


  Future<void> onNormalLogin(ApplyConfirmPasswordEvent event, Emitter emit) async {
    emit(const ButtonLoadingState());
    final response = await confirmPasswordUseCase.confirmPassword(event.confirmPasswordRequestModel,);
    print('objjj>>'+jsonEncode(event.confirmPasswordRequestModel));
    await response.fold((l) async {emit(ErrorState(l));}, (r) async {
        if ((r).statusCode == 200 || (r).statusCode == 201) {
          Get.context!.push(AppRouter.login);
        } else {
          handleError(errors: r.errors ?? [], statusCode: r.statusCode ?? 0);
        }
        emit(LoadedState(r));
      },
    );
  }
}
