import 'package:dartz/dartz.dart';

import '../../data/model/forget_password_request_model.dart';

abstract class ForgetPasswordRepository {
  Future<Either<dynamic, dynamic>> forgetPassword({required ForgetPasswordRequestModel model,});
}
