import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mawidak/core/data/constants/global_obj.dart';
import 'package:mawidak/core/data/constants/shared_preferences_constants.dart';
import 'package:mawidak/core/extensions/string_extensions.dart';
import 'package:mawidak/core/global/state/base_state.dart';
import 'package:mawidak/core/services/local_storage/secure_storage/secure_storage_service.dart';
import 'package:mawidak/features/change_password/domain/use_case/change_password_use_case.dart';
import 'package:mawidak/features/change_password/presentation/bloc/change_password_event.dart';


class ChangePasswordBloc extends Bloc<ChangePasswordEvent, BaseState> {
  final ChangePasswordUseCase changePasswordUseCase;
  TextEditingController currentPass = TextEditingController();
  TextEditingController newPass = TextEditingController();
  TextEditingController confirmNewPass = TextEditingController();

  ChangePasswordBloc({required this.changePasswordUseCase}) : super(ButtonDisabledState()) {
    on<ApplyChangePasswordEvent>(onApplyDoctorProfileEvent);
    on<ApplyValidationEvent>(onValidateAllFields);
  }

  Future<void> onApplyDoctorProfileEvent(ApplyChangePasswordEvent event, Emitter emit) async {
    emit(ButtonLoadingState());
    final response = await changePasswordUseCase.changePassword(model:event.model);
    await response.fold((l) async {emit(ErrorState(l));}, (r) async {
        emit(LoadedState(r,isMap:false));
        await SecureStorageService().write(key: SharPrefConstants.passwordKey, value:newPass.text);
        if (!Get.navigatorState!.mounted) return;
        Navigator.pop(Get.navigatorState!.context);
      },
    );
  }

  Future<void> onValidateAllFields(ApplyValidationEvent event, Emitter emit) async {
    if (!currentPass.text.isEmptyOrNull && !newPass.text.isEmptyOrNull && confirmNewPass.text.length <= 50
    && newPass.text==confirmNewPass.text ) {
      emit(ButtonEnabledState());
    } else {
      emit(ButtonDisabledState());
    }
  }

}
