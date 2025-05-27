import 'package:mawidak/features/confirm_password/data/model/confirm_password_request_model.dart';

abstract class ConfirmPasswordEvent {
  const ConfirmPasswordEvent();
}

class ApplyConfirmPasswordEvent extends ConfirmPasswordEvent {
  final ConfirmPasswordRequestModel confirmPasswordRequestModel;
  const ApplyConfirmPasswordEvent({required this.confirmPasswordRequestModel}) : super();
}

class ValidationEvent extends ConfirmPasswordEvent {
  const ValidationEvent() : super();
}

