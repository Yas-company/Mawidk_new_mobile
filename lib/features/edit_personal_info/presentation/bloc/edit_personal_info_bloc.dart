import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mawidak/core/data/constants/global_obj.dart';
import 'package:mawidak/core/data/constants/shared_preferences_constants.dart';
import 'package:mawidak/core/global/state/base_state.dart';
import 'package:mawidak/core/services/local_storage/shared_preference/shared_preference_service.dart';
import 'package:mawidak/features/edit_personal_info/data/model/profile_response_model.dart';
import 'package:mawidak/features/edit_personal_info/domain/use_case/edit_personal_info_use_case.dart';
import 'package:mawidak/features/edit_personal_info/presentation/bloc/edit_personal_info_event.dart';

class EditPersonalInfoBloc extends Bloc<EditPersonalInfoEvent, BaseState> {
  final EditPersonalInfoUseCase editPersonalInfoUseCase;

  final TextEditingController name = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController email = TextEditingController();

  String originalName = '';
  String originalEmail = '';

  EditPersonalInfoBloc({required this.editPersonalInfoUseCase}) : super(ButtonDisabledState()) {
    on<ApplyEditPersonalInfoEvent>(onApplyEditPersonalInfoEvent);
    on<ApplyValidationEvent>(onValidateAllFields);
    on<GetProfileEvent>(onGetProfile);

    // Load from shared preferences initially
    originalName = SharedPreferenceService().getString(SharPrefConstants.userName);
    originalEmail = SharedPreferenceService().getString(SharPrefConstants.emailKey);

    name.text = originalName;
    phone.text = SharedPreferenceService().getString(SharPrefConstants.phone);
    email.text = originalEmail;
  }

  Future<void> onApplyEditPersonalInfoEvent(ApplyEditPersonalInfoEvent event, Emitter emit) async {
    print('originalName>'+originalName.toString());
    print('originalEmail>'+originalEmail.toString());
    print('name.text>'+name.text.toString());
    print('email.text>'+email.text.toString());
    emit(ButtonLoadingState());
    final response = await editPersonalInfoUseCase.editProfile(model: event.model);
    await response.fold(
          (l) async {
        emit(ErrorState(l));
      },
          (r) async {
        await SharedPreferenceService().setString(SharPrefConstants.userName, event.model.name);
        await SharedPreferenceService().setString(SharPrefConstants.emailKey, event.model.email);

        // Update original values
        originalName = event.model.name;
        originalEmail = event.model.email;

        emit(LoadedState(r, isMap: false));
        if (!Get.navigatorState!.mounted) return;
        Navigator.pop(Get.navigatorState!.context);
      },
    );
  }

  void onValidateAllFields(ApplyValidationEvent event, Emitter emit) {
    final isEmailValid = event.email.isEmpty ||
        RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(event.email);
    final isNameValid = event.name.isNotEmpty && event.name.length <= 50;

    final isChanged = event.name != originalName || event.email != originalEmail;

    if (isEmailValid && isNameValid && isChanged) {
      emit(ButtonEnabledState());
    } else {
      emit(ButtonDisabledState());
    }
  }

  Future<void> onGetProfile(GetProfileEvent event, Emitter emit) async {
    emit(LoadingState());
    final response = await editPersonalInfoUseCase.getProfile();
    await response.fold(
          (l) async {
        emit(ErrorState(l));
      },
          (r) async {
        final ProfileData item = r.model?.model ?? ProfileData();
        name.text = item.name ?? '';
        email.text = item.email ?? '';

        originalName = item.name ?? '';
        originalEmail = item.email ?? '';

        await SharedPreferenceService().setString(
          SharPrefConstants.userName,
          originalName,
        );
        await SharedPreferenceService().setString(
          SharPrefConstants.emailKey,
          originalEmail,
        );

        emit(LoadedState(r, showToast: false));
        add(ApplyValidationEvent(name: originalName, email: originalEmail));
      },
    );
  }
}
