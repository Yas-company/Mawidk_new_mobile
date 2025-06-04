import 'package:dartz/dartz.dart';

abstract class ShowFileRepository {
  Future<Either<dynamic, dynamic>> getBasicInfo({required int id});
}
