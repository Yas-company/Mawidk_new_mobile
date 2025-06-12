import 'package:dartz/dartz.dart';
import 'package:mawidak/features/appointments/data/model/accept_appointment_request_model.dart';
import 'package:mawidak/features/appointments/data/model/cancel_appointment_request_model.dart';
import 'package:mawidak/features/appointments/domain/repository/doctor_appointments_repository.dart';

class DoctorAppointmentsUseCase {
  final DoctorAppointmentsRepository doctorAppointmentsRepository;

  DoctorAppointmentsUseCase({required this.doctorAppointmentsRepository});

  Future<Either> getDoctorAppointments() async {
    return await doctorAppointmentsRepository.getDoctorAppointments();
  }

  Future<Either> getDoctorPendingAppointments() async {
    return await doctorAppointmentsRepository.getDoctorPendingAppointments();
  }


  Future<Either> cancelAppointment({required int id,required CancelAppointmentRequestModel model}) async {
    return await doctorAppointmentsRepository.cancelAppointment(id: id,model:model);
  }

  Future<Either> acceptAppointment({required int id,required AcceptAppointmentRequestModel model}) async {
    return await doctorAppointmentsRepository.acceptAppointment(id: id,model:model);
  }
}
