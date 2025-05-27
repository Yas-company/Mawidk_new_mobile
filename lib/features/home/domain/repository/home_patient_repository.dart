import 'package:dartz/dartz.dart';

abstract class HomePatientRepository {
  Future<Either<dynamic, dynamic>> getDoctors();
  Future<Either<dynamic, dynamic>> getBanners();
  Future<Either<dynamic, dynamic>> getDoctorProfileStatus();
  Future<Either<dynamic, dynamic>> getDoctorHomeDetails();
}
