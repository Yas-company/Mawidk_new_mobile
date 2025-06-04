import 'package:dartz/dartz.dart';

abstract class SearchForDoctorsRepository {
  Future<Either<dynamic, dynamic>> searchForDoctor({required String key});
}
