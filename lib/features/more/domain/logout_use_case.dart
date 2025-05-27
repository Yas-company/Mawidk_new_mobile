import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:mawidak/features/more/domain/logout_repository.dart';


class LogoutUseCase {
  final LogoutRepository logoutRepository;

  LogoutUseCase({required this.logoutRepository});

  Future<Either> makeLogout() async {
    return await logoutRepository.makeLogout();
  }
  Future<Either> deleteAccount() async {
    return await logoutRepository.deleteAccount();
  }

  Future<Either> updatePhoto({required File file}) async {
    return await logoutRepository.updatePhoto(file: file);
  }
}
