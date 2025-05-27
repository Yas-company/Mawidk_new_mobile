import 'package:dartz/dartz.dart';
import 'package:mawidak/core/base_network/api_endpoints_constants.dart';
import 'package:mawidak/core/base_network/general_response_model.dart';
import 'package:mawidak/core/base_network/network_repository.dart';
import 'package:mawidak/features/change_password/data/model/change_password_request_model.dart';
import 'package:mawidak/features/change_password/domain/repository/change_password_repository.dart';
import '../../../../core/base_network/error/handler/error_model.dart';
import '../../../../core/base_network/error/handler/exception_enum.dart';

class ChangePasswordRepositoryImpl extends MainRepository implements ChangePasswordRepository {
  ChangePasswordRepositoryImpl({
    required super.remoteData,
    required super.networkInfo,
  });

  @override
  Future<Either> changePassword({required ChangePasswordRequestModel model}) async {
    try {
      final result = await remoteData.post(
        body:model.toJson(),
        path: ApiEndpointsConstants.changePassword,
        headers: headers,
        model: GeneralResponseModel(),
      );
      return result;
    } catch (e) {
      return Left(
        ErrorExceptionModel(
            message: e.toString(),
            exceptionEnum: ExceptionEnum.unknownException),
      );
    }
  }

}
