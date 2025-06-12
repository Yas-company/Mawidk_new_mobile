import 'package:mawidak/features/appointments/data/model/accept_appointment_request_model.dart';
import 'package:mawidak/features/appointments/data/model/cancel_appointment_request_model.dart';

abstract class PatientAppointmentsEvent {
  const PatientAppointmentsEvent();
}

class ApplyPatientAppointmentsEvent extends PatientAppointmentsEvent {
  const ApplyPatientAppointmentsEvent() : super();
}

class ApplyPatientCancelEvent extends PatientAppointmentsEvent {
  final int id;
  final AcceptAppointmentRequestModel model;
  const ApplyPatientCancelEvent({required this.id,required this.model}) : super();
}

