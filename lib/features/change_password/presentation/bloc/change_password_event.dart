import 'package:mawidak/features/change_password/data/model/change_password_request_model.dart';

abstract class ChangePasswordEvent {
  const ChangePasswordEvent();
}

class ApplyChangePasswordEvent extends ChangePasswordEvent {
  final ChangePasswordRequestModel model;
  const ApplyChangePasswordEvent({required this.model}) : super();
}

class ApplyValidationEvent extends ChangePasswordEvent {
  const ApplyValidationEvent() : super();
}