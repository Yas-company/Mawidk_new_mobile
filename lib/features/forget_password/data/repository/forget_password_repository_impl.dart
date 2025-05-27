import 'package:dartz/dartz.dart';
import 'package:mawidak/core/base_network/api_endpoints_constants.dart';
import 'package:mawidak/core/base_network/general_response_model.dart';
import 'package:mawidak/core/base_network/network_repository.dart';
import 'package:mawidak/features/forget_password/data/model/forget_password_request_model.dart';
import 'package:mawidak/features/forget_password/domain/repository/forget_password_repo.dart';
import '../../../../core/base_network/error/handler/error_model.dart';
import '../../../../core/base_network/error/handler/exception_enum.dart';

class ForgetPasswordRepositoryImpl extends MainRepository implements ForgetPasswordRepository {
  ForgetPasswordRepositoryImpl({
    required super.remoteData,
    required super.networkInfo, // For checking network connection
  });

  @override
  Future<Either> forgetPassword({required ForgetPasswordRequestModel model,}) async {
    try {
      final result = await remoteData.post(
        body: model.toJson(),
        path: ApiEndpointsConstants.forgetPassword,
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
