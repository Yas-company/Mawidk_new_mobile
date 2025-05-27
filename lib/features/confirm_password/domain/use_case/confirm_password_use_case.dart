import 'package:dartz/dartz.dart';
import '../../data/model/confirm_password_request_model.dart';
import '../repository/confirm_password_repo.dart';

class ConfirmPasswordUseCase {
  final ConfirmPasswordRepository confirmPasswordRepository;

  ConfirmPasswordUseCase({required this.confirmPasswordRepository});

  Future<Either> confirmPassword(ConfirmPasswordRequestModel params) async {
    return await confirmPasswordRepository.confirmPassword(model: params);
  }
}
