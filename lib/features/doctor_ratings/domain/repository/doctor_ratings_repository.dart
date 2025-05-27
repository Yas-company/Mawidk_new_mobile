import 'package:dartz/dartz.dart';

abstract class DoctorRatingsRepository {
  Future<Either<dynamic, dynamic>> getDoctorRatingsById({required int id});
}
