import 'package:dartz/dartz.dart';
import 'package:mawidak/features/verify_otp/data/model/verify_otp_request_model.dart';


abstract class VerifyOtpRepository {
  Future<Either<dynamic, dynamic>> verifyOtp({required VerifyOtpRequestModel model,
  required bool isLogin});
}
