import 'package:dartz/dartz.dart';
import 'package:mawidak/features/appointments/data/model/accept_appointment_request_model.dart';

abstract class PatientAppointmentsRepository {
  Future<Either<dynamic, dynamic>> getPatientAppointments();
  Future<Either<dynamic, dynamic>> cancelAppointment({required int id,required AcceptAppointmentRequestModel model});

}
