import 'package:dartz/dartz.dart';
import 'package:mawidak/features/appointments/data/model/accept_appointment_request_model.dart';
import 'package:mawidak/features/patient_appointments/domain/repository/patient_appointments_repository.dart';

class PatientAppointmentsUseCase {
  final PatientAppointmentsRepository patientAppointmentsRepository;

  PatientAppointmentsUseCase({required this.patientAppointmentsRepository});

  Future<Either> getPatientAppointments() async {
    return await patientAppointmentsRepository.getPatientAppointments();
  }

  Future<Either> cancelAppointment({required int id,required AcceptAppointmentRequestModel model}) async {
    return await patientAppointmentsRepository.cancelAppointment(id: id,model:model);
  }
}
