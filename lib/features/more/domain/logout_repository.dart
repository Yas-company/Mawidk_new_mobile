import 'dart:io';

import 'package:dartz/dartz.dart';

abstract class LogoutRepository {
  Future<Either<dynamic, dynamic>> makeLogout();
  Future<Either<dynamic, dynamic>> deleteAccount();
  Future<Either<dynamic, dynamic>> updatePhoto({required File file});
}
