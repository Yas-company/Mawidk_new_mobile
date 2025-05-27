import 'package:dartz/dartz.dart';
import '../../data/model/confirm_password_request_model.dart';

abstract class ConfirmPasswordRepository {
  Future<Either<dynamic, dynamic>> confirmPassword({required ConfirmPasswordRequestModel model,});
}
