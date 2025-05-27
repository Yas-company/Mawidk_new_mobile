import 'package:dartz/dartz.dart';
import 'package:mawidak/features/change_password/data/model/change_password_request_model.dart';
import 'package:mawidak/features/change_password/domain/repository/change_password_repository.dart';

class ChangePasswordUseCase {
  final ChangePasswordRepository changePasswordRepository;

  ChangePasswordUseCase({required this.changePasswordRepository});

  Future<Either> changePassword({required ChangePasswordRequestModel model}) async {
    return await changePasswordRepository.changePassword(model: model);
  }
}