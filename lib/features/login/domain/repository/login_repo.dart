import 'package:dartz/dartz.dart';
import 'package:mawidak/features/login/data/model/loction_request_model.dart';
import '../../data/model/login_request_model.dart';

abstract class LoginRepository {
  Future<Either<dynamic, dynamic>> login({required LoginRequestModel model,});
  Future<Either<dynamic, dynamic>> updateLocation({required LocationRequestModel model,});
}
