import 'package:dartz/dartz.dart';

abstract class PatientsRepository {
  Future<Either<dynamic, dynamic>> getDoctorPatients();
}
