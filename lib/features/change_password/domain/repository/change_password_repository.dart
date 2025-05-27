import 'package:dartz/dartz.dart';
import 'package:mawidak/features/change_password/data/model/change_password_request_model.dart';

abstract class ChangePasswordRepository {
  Future<Either<dynamic, dynamic>> changePassword({required ChangePasswordRequestModel model,});
}