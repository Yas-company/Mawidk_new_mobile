import 'package:dartz/dartz.dart';
import 'package:mawidak/features/home/domain/repository/home_patient_repository.dart';


class HomePatientUseCase {
  final HomePatientRepository homePatientRepository;

  HomePatientUseCase({required this.homePatientRepository});

  Future<Either> getDoctors() async {
    return await homePatientRepository.getDoctors();
  }
  Future<Either> getBanners() async {
    return await homePatientRepository.getBanners();
  }

  Future<Either> getDoctorProfileStatus() async {
    return await homePatientRepository.getDoctorProfileStatus();
  }

  Future<Either> getDoctorHomeDetails() async {
    return await homePatientRepository.getDoctorHomeDetails();
  }
}
