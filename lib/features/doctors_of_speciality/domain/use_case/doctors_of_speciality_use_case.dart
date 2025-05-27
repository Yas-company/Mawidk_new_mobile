import 'package:dartz/dartz.dart';
import 'package:mawidak/features/doctors_of_speciality/domain/repository/doctors_of_speciality_repository.dart';

class DoctorsOfSpecialityUseCase {
  final DoctorsOfSpecialityRepository doctorsOfSpecialityRepository;

  DoctorsOfSpecialityUseCase({required this.doctorsOfSpecialityRepository});

  Future<Either> getDoctors({required int id}) async {
    return await doctorsOfSpecialityRepository.getDoctors(id: id);
  }
}
