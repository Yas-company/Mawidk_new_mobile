import 'package:dartz/dartz.dart';

abstract class DoctorsOfSpecialityRepository {
  Future<Either<dynamic, dynamic>> getDoctors({required int id,});
}