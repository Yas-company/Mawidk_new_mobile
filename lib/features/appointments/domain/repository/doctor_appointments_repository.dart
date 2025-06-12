import 'package:dartz/dartz.dart';
import 'package:mawidak/features/appointments/data/model/accept_appointment_request_model.dart';
import 'package:mawidak/features/appointments/data/model/cancel_appointment_request_model.dart';

abstract class DoctorAppointmentsRepository {
  Future<Either<dynamic, dynamic>> getDoctorAppointments();
  Future<Either<dynamic, dynamic>> getDoctorPendingAppointments();
  Future<Either<dynamic, dynamic>> cancelAppointment({required int id,required CancelAppointmentRequestModel model});
  Future<Either<dynamic, dynamic>> acceptAppointment({required int id,required AcceptAppointmentRequestModel model});
}
