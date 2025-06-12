import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mawidak/core/data/constants/global_obj.dart';
import 'package:mawidak/core/data/constants/shared_preferences_constants.dart';
import 'package:mawidak/core/extensions/string_extensions.dart';
import 'package:mawidak/core/global/global_func.dart';
import 'package:mawidak/core/global/state/base_state.dart';
import 'package:mawidak/core/services/local_storage/shared_preference/shared_preference_service.dart';
import 'package:mawidak/features/contact_us/data/model/contact_us_request_model.dart';
import 'package:mawidak/features/contact_us/domain/use_case/contact_us_use_case.dart';
import 'package:mawidak/features/contact_us/presentation/bloc/contact_us_event.dart';


class ContactUsBloc extends Bloc<ContactUsEvent, BaseState> {
  final ContactUsUseCase contactUsUseCase;
  TextEditingController phone = TextEditingController();
  TextEditingController email =  TextEditingController();
  TextEditingController message =  TextEditingController();

  ContactUsRequestModel model = ContactUsRequestModel();
  ContactUsBloc({required this.contactUsUseCase}) : super(ButtonDisabledState()) {
    on<ApplyContactUsEvent>(onApplyContactUsEvent);
    on<ApplyValidationEvent>(onValidateAllFields);
  }

  Future<void> onApplyContactUsEvent(ApplyContactUsEvent event, Emitter emit) async {
    emit(ButtonLoadingState());
    event.model.phone = SharedPreferenceService().getString(SharPrefConstants.phone);
    event.model.email = SharedPreferenceService().getString(SharPrefConstants.emailKey);
    print('modelIs>>'+jsonEncode(event.model));
    final response = await contactUsUseCase.contactUs(model:event.model);
    await response.fold((l) async {emit(ErrorState(l));},
          (r) async {
        emit(LoadedState(r,isMap:false));
        if (!Get.navigatorState!.mounted) return;
        Navigator.pop(Get.navigatorState!.context);
      },
    ); 
  }

  void onValidateAllFields(ApplyValidationEvent event, Emitter emit) {
    // final isPhoneValid = !phone.text.isEmptyOrNull && isValidSaudiPhoneNumber(phone.text);
    final isMessageValid = !message.text.isEmptyOrNull;
    // final isEmailValid = email.text.isEmpty || RegExp(
    //     r"^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$"
    // ).hasMatch(email.text);
    // if (isPhoneValid && isMessageValid && isEmailValid) {
    if (isMessageValid) {
      emit(ButtonEnabledState());
    } else {
      emit(ButtonDisabledState());
    }
  }

}
