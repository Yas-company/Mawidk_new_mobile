import 'package:mawidak/features/contact_us/data/model/contact_us_request_model.dart';

abstract class ContactUsEvent {
  const ContactUsEvent();
}

class ApplyContactUsEvent extends ContactUsEvent {
  final ContactUsRequestModel model;
  const ApplyContactUsEvent({required this.model}) : super();
}

class ApplyValidationEvent extends ContactUsEvent {
  const ApplyValidationEvent() : super();
}