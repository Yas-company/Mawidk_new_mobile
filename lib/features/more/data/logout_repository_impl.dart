import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:mawidak/core/base_network/api_endpoints_constants.dart';
import 'package:mawidak/core/base_network/general_response_model.dart';
import 'package:mawidak/core/base_network/network_repository.dart';
import 'package:mawidak/features/more/data/model/update_photo_response_model.dart';
import 'package:mawidak/features/more/domain/logout_repository.dart';
import '../../../../../core/base_network/error/handler/error_model.dart';
import '../../../../../core/base_network/error/handler/exception_enum.dart';

class LogoutRepositoryImpl extends MainRepository implements LogoutRepository {
  LogoutRepositoryImpl({
    required super.remoteData,
    required super.networkInfo, // For checking network connection
  });

  @override
  Future<Either> makeLogout() async {
    try {
      final result = await remoteData.post(
        path: ApiEndpointsConstants.logout,
        headers: headers,
        model: GeneralResponseModel(),
      );
      return result;
    } catch (e) {
      // If an error occurs, return the error wrapped in Left
      return Left(
        ErrorExceptionModel(
            message: e.toString(),
            exceptionEnum: ExceptionEnum.unknownException),
      );
    }
  }
  @override
  Future<Either> deleteAccount() async {
    try {
      final result = await remoteData.post(
        path: ApiEndpointsConstants.deleteAccount,
        headers: headers,
        model: GeneralResponseModel(),
      );
      return result;
    } catch (e) {
      // If an error occurs, return the error wrapped in Left
      return Left(
        ErrorExceptionModel(
            message: e.toString(),
            exceptionEnum: ExceptionEnum.unknownException),
      );
    }
  }

  @override
  Future<Either> updatePhoto({required File file}) async{
    try {
      final result = await remoteData.postPhoto(
        file: file,
        path: ApiEndpointsConstants.updatePhoto,
        headers: headers,
        model: GeneralResponseModel(model: UpdatePhotoResponseModel()),
      );
      return result;
    } catch (e) {
      // If an error occurs, return the error wrapped in Left
      return Left(
        ErrorExceptionModel(
            message: e.toString(),
            exceptionEnum: ExceptionEnum.unknownException),
      );
    }
  }
}
