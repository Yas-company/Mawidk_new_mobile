import 'package:dartz/dartz.dart';
import 'package:mawidak/core/base_network/api_endpoints_constants.dart';
import 'package:mawidak/core/base_network/general_response_model.dart';
import 'package:mawidak/core/base_network/network_repository.dart';
import 'package:mawidak/features/confirm_password/data/model/confirm_password_request_model.dart';
import 'package:mawidak/features/confirm_password/data/model/confirm_password_response_model.dart';
import 'package:mawidak/features/confirm_password/domain/repository/confirm_password_repo.dart';
import '../../../../core/base_network/error/handler/error_model.dart';
import '../../../../core/base_network/error/handler/exception_enum.dart';

class ConfirmPasswordRepositoryImpl extends MainRepository implements ConfirmPasswordRepository {
  ConfirmPasswordRepositoryImpl({
    required super.remoteData,
    required super.networkInfo, // For checking network connection
  });

  @override
  Future<Either> confirmPassword({required ConfirmPasswordRequestModel model,}) async {
    try {
      final result = await remoteData.post(
        body: model.toJson(),
        path: ApiEndpointsConstants.confirmPassword,
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
}
