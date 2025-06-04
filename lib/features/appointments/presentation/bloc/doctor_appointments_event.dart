import 'package:mawidak/features/appointments/data/model/cancel_appointment_request_model.dart';

abstract class DoctorAppointmentsEvent {
  const DoctorAppointmentsEvent();
}

class ApplyDoctorAppointmentsEvent extends DoctorAppointmentsEvent {
  const ApplyDoctorAppointmentsEvent() : super();
}

class ApplyDoctorCancelEvent extends DoctorAppointmentsEvent {
  final int id;
  final CancelAppointmentRequestModel model;
  const ApplyDoctorCancelEvent({required this.id,required this.model}) : super();
}