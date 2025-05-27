import 'package:dartz/dartz.dart';
import 'package:mawidak/features/doctor_profile/data/model/favourite_request_model.dart';
import 'package:mawidak/features/doctor_profile/domain/repository/doctor_profile_repository.dart';

class DoctorProfileUseCase {
  final DoctorProfileRepository doctorProfileRepository;

  DoctorProfileUseCase({required this.doctorProfileRepository});

  Future<Either> getDoctorProfile({required int id}) async {
    return await doctorProfileRepository.getDoctorProfile(id: id);
  }

  Future<Either> addToFavourite({required FavouriteRequestModel model}) async {
    return await doctorProfileRepository.addToFavourite(model: model);
  }
}
