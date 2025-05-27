import 'package:dartz/dartz.dart';
import '../../data/model/forget_password_request_model.dart';
import '../repository/forget_password_repo.dart';

class ForgetPasswordUseCase {
  final ForgetPasswordRepository forgetPasswordRepository;

  ForgetPasswordUseCase({required this.forgetPasswordRepository});

  Future<Either> forgetPassword(ForgetPasswordRequestModel params) async {
    return await forgetPasswordRepository.forgetPassword(model: params);
  }
}
