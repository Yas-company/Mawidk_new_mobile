import 'package:dartz/dartz.dart';
import 'package:mawidak/features/doctor_profile/data/model/favourite_request_model.dart';

abstract class DoctorProfileRepository {
  Future<Either<dynamic, dynamic>> getDoctorProfile({required int id});
  Future<Either<dynamic, dynamic>> addToFavourite({required FavouriteRequestModel model});
}
