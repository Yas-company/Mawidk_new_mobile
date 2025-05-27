import 'package:dartz/dartz.dart';
import 'package:mawidak/features/appointment/data/model/appointment_reques_model.dart';

abstract class AppointmentBookingRepository {
  Future<Either<dynamic, dynamic>> bookAppointment({required AppointmentRequestModel model});
}
