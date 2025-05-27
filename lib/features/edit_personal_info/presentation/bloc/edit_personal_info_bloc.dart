import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mawidak/core/data/constants/global_obj.dart';
import 'package:mawidak/core/data/constants/shared_preferences_constants.dart';
import 'package:mawidak/core/global/state/base_state.dart';
import 'package:mawidak/core/services/local_storage/secure_storage/secure_storage_service.dart';
import 'package:mawidak/features/edit_personal_info/domain/use_case/edit_personal_info_use_case.dart';
import 'package:mawidak/features/edit_personal_info/presentation/bloc/edit_personal_info_event.dart';


class EditPersonalInfoBloc extends Bloc<EditPersonalInfoEvent, BaseState> {
  final EditPersonalInfoUseCase editPersonalInfoUseCase;
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();

  EditPersonalInfoBloc({required this.editPersonalInfoUseCase}) : super(ButtonDisabledState()) {
    on<ApplyEditPersonalInfoEvent>(onApplyEditPersonalInfoEvent);
    on<ApplyValidationEvent>(onValidateAllFields);
    on<LoadPhoneNumberEvent>(onGetPhone);
  }

  Future<void> onApplyEditPersonalInfoEvent(ApplyEditPersonalInfoEvent event, Emitter emit) async {
    emit(ButtonLoadingState());
    final response = await editPersonalInfoUseCase.editProfile(model:event.model);
    await response.fold((l) async {emit(ErrorState(l));}, (r) async {
      emit(LoadedState(r,isMap:false));
      // await SecureStorageService().write(key: SharPrefConstants.passwordKey, value:newPass.text);
      if (!Get.navigatorState!.mounted) return;
      Navigator.pop(Get.navigatorState!.context);
    },
    );
  }


  void onValidateAllFields(ApplyValidationEvent event, Emitter emit) {
    final isEmailValid = email.text.isEmpty || RegExp(
        r"^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$"
    ).hasMatch(email.text); // email is either empty or a valid format
    final isNameValid = name.text.isEmpty || name.text.length <= 50; // name is either empty or <= 50 chars
    if (isEmailValid && isNameValid) {
      emit(ButtonEnabledState());
    } else {
      emit(ButtonDisabledState());
    }
  }

  Future<void> onGetPhone(LoadPhoneNumberEvent event, Emitter emit) async {
    // phone.text = await SecureStorageService().read(key: SharPrefConstants.phone) ?? '';
    // emit(CategoryUpdatedState());
  }
}
