import 'package:dartz/dartz.dart';
import 'package:mawidak/features/appointment/data/model/appointment_reques_model.dart';
import 'package:mawidak/features/appointment/domain/repository/appoitment_booking_repository.dart';

class AppointmentBookingUseCase {
  final AppointmentBookingRepository appointmentBookingRepository;

  AppointmentBookingUseCase({required this.appointmentBookingRepository});

  Future<Either> bookAppointment({required AppointmentRequestModel model}) async {
    return await appointmentBookingRepository.bookAppointment(model: model);
  }
}
