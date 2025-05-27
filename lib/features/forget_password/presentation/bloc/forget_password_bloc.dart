import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mawidak/core/base_network/error/handler/error_model.dart';
import 'package:mawidak/core/data/constants/app_router.dart';
import 'package:mawidak/core/extensions/string_extensions.dart';
import 'package:mawidak/core/global/state/base_state.dart';
import 'package:mawidak/features/forget_password/domain/use_case/forget_password_use_case.dart';
import 'package:mawidak/features/forget_password/presentation/bloc/forget_password_event.dart';
import '../../../../core/data/constants/global_obj.dart';



class ForgetPasswordBloc extends Bloc<ForgetPasswordEvent,BaseState> {
  final ForgetPasswordUseCase forgetPasswordUseCase;
  TextEditingController phone = TextEditingController();
  ForgetPasswordBloc({required this.forgetPasswordUseCase}) : super(ButtonDisabledState()) {
    on<ApplyForgetPasswordEvent>(sendOtpForForgetPassword);
    on<ValidationEvent>(onValidateAllFields);
  }

  void onValidateAllFields(ValidationEvent event, Emitter emit) {
    if (!phone.text.isEmptyOrNull) {
      emit(ButtonEnabledState());
    } else {
      emit(ButtonDisabledState());
    }
  }

  Future<void> sendOtpForForgetPassword(ApplyForgetPasswordEvent event, Emitter emit) async {
    emit(const ButtonLoadingState());
    final response = await forgetPasswordUseCase.forgetPassword(event.forgetPasswordRequestModel,);
    await response.fold(
      (l) async {
        emit(ErrorState(l));
      },
      (r) async {
        if ((r).statusCode == 200 || (r).statusCode == 201) {
          // Get.context!.push(AppRouter.verifyOtp,extra:event.forgetPasswordRequestModel.phone??'');
          Get.context!.push(AppRouter.verifyOtp,extra: {
            'phone':event.forgetPasswordRequestModel.phone,
            'isLogin': false,
          },);
        } else {
          handleError(errors: r.errors ?? [], statusCode: r.statusCode ?? 0);
        }
        emit(LoadedState(r));
      },
    );
  }

}
