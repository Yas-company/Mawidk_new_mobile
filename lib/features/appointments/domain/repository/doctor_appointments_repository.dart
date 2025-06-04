import 'package:dartz/dartz.dart';
import 'package:mawidak/features/appointments/data/model/cancel_appointment_request_model.dart';

abstract class DoctorAppointmentsRepository {
  Future<Either<dynamic, dynamic>> getDoctorAppointments();
  Future<Either<dynamic, dynamic>> cancelAppointment({required int id,required CancelAppointmentRequestModel model});
}
