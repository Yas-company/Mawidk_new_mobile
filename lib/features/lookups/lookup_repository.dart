import 'package:dartz/dartz.dart';

abstract class LookupRepository {
  Future<Either<dynamic, dynamic>> fetchCities();
}
