import 'package:dartz/dartz.dart';
import 'package:mawidak/features/all_patients/domain/repository/patients_repository.dart';

class PatientsUseCase {
  final PatientsRepository patientsRepository;

  PatientsUseCase({required this.patientsRepository});

  Future<Either> getDoctorPatients() async {
    return await patientsRepository.getDoctorPatients();
  }
}
