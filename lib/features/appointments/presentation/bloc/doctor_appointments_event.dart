import 'package:mawidak/features/appointments/data/model/accept_appointment_request_model.dart';
import 'package:mawidak/features/appointments/data/model/cancel_appointment_request_model.dart';

abstract class DoctorAppointmentsEvent {
  const DoctorAppointmentsEvent();
}

class ApplyDoctorAppointmentsEvent extends DoctorAppointmentsEvent {
  const ApplyDoctorAppointmentsEvent() : super();
}

class ApplyDoctorPendingAppointmentsEvent extends DoctorAppointmentsEvent {
  const ApplyDoctorPendingAppointmentsEvent() : super();
}

class ApplyDoctorCancelEvent extends DoctorAppointmentsEvent {
  final int id;
  final CancelAppointmentRequestModel model;
  const ApplyDoctorCancelEvent({required this.id,required this.model}) : super();
}

class ApplyDoctorAcceptEvent extends DoctorAppointmentsEvent {
  final int id;
  final AcceptAppointmentRequestModel model;
  const ApplyDoctorAcceptEvent({required this.id,required this.model}) : super();
}