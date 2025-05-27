import 'package:dartz/dartz.dart';
import 'package:mawidak/features/login/data/model/login_request_model.dart';
import '../../data/model/verify_otp_request_model.dart';
import '../repository/verify_otp_repo.dart';

class VerifyOtpUseCase {
  final VerifyOtpRepository verifyOtpRepository;

  VerifyOtpUseCase({required this.verifyOtpRepository});

  Future<Either> verifyOtp(VerifyOtpRequestModel params,bool isLogin) async {
    return await verifyOtpRepository.verifyOtp(model: params,isLogin:isLogin);
  }
}
