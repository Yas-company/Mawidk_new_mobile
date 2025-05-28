import 'package:mawidak/features/edit_personal_info/data/model/edit_personal_info_request_model.dart';

abstract class EditPersonalInfoEvent {
  const EditPersonalInfoEvent();
}

class ApplyEditPersonalInfoEvent extends EditPersonalInfoEvent {
  final EditPersonalInfoRequestModel model;
  const ApplyEditPersonalInfoEvent({required this.model}) : super();
}

class ApplyValidationEvent extends EditPersonalInfoEvent {
  const ApplyValidationEvent() : super();
}

class LoadPhoneNumberEvent extends EditPersonalInfoEvent {}

class GetProfileEvent extends EditPersonalInfoEvent {}
