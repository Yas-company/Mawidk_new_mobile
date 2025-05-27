import 'package:mawidak/features/appointment/data/model/appointment_reques_model.dart';

abstract class AppointmentBookingEvent {
  const AppointmentBookingEvent();
}

class ApplyAppointmentBookingEvent extends AppointmentBookingEvent {
  final AppointmentRequestModel model;
  const ApplyAppointmentBookingEvent({required this.model}) : super();
}

