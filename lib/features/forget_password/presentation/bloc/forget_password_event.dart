import 'package:mawidak/features/forget_password/data/model/forget_password_request_model.dart';
import 'package:mawidak/features/login/data/model/login_request_model.dart';

abstract class ForgetPasswordEvent {
  const ForgetPasswordEvent();
}

class ApplyForgetPasswordEvent extends ForgetPasswordEvent {
  final ForgetPasswordRequestModel forgetPasswordRequestModel;
  const ApplyForgetPasswordEvent({required this.forgetPasswordRequestModel}) : super();
}

class ValidationEvent extends ForgetPasswordEvent {
  const ValidationEvent() : super();
}

