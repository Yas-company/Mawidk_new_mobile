import 'package:dartz/dartz.dart';
import 'package:mawidak/features/doctor_ratings/domain/repository/doctor_ratings_repository.dart';

class DoctorRatingsUseCase {
  final DoctorRatingsRepository doctorRatingsRepository;

  DoctorRatingsUseCase({required this.doctorRatingsRepository});

  Future<Either> getDoctorRatingsById({required int id}) async {
    return await doctorRatingsRepository.getDoctorRatingsById(id:id);
  }
}
