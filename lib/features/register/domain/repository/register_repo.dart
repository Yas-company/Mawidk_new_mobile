import 'package:dartz/dartz.dart';

import '../../data/model/register_request_model.dart';

abstract class RegisterRepository {
  Future<Either<dynamic, dynamic>> register({required RegisterRequestModel model,});
}
