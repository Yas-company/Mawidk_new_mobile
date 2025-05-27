import 'package:dartz/dartz.dart';
import 'package:mawidak/core/base_network/api_endpoints_constants.dart';
import 'package:mawidak/core/base_network/general_response_model.dart';
import 'package:mawidak/core/base_network/network_repository.dart';
import 'package:mawidak/features/register/data/model/register_response_model.dart';
import 'package:mawidak/features/register/domain/repository/register_repo.dart';

import '../../../../core/base_network/error/handler/error_model.dart';
import '../../../../core/base_network/error/handler/exception_enum.dart';
import '../model/register_request_model.dart';

class RegisterRepositoryImpl extends MainRepository implements RegisterRepository {
  RegisterRepositoryImpl({
    required super.remoteData,
    required super.networkInfo, // For checking network connection
  });

  @override
  Future<Either> register({required RegisterRequestModel model,}) async {
    try {
      final result = await remoteData.post(
        body: model.toJson(),
        path: ApiEndpointsConstants.register,
        headers: headers,
        model: GeneralResponseModel(model: RegisterResponseModel()),
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
