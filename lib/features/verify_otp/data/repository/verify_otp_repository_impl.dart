import 'package:dartz/dartz.dart';
import 'package:mawidak/core/base_network/api_endpoints_constants.dart';
import 'package:mawidak/core/base_network/client/dio_client.dart';
import 'package:mawidak/core/base_network/general_response_model.dart';
import 'package:mawidak/core/base_network/network_repository.dart';
import 'package:mawidak/features/login/data/model/login_response_model.dart';
import 'package:mawidak/features/verify_otp/data/model/verify_otp_request_model.dart';
import 'package:mawidak/features/verify_otp/domain/repository/verify_otp_repo.dart';
import '../../../../core/base_network/error/handler/error_model.dart';
import '../../../../core/base_network/error/handler/exception_enum.dart';

class VerifyOtpRepositoryImpl extends MainRepository implements VerifyOtpRepository {
  VerifyOtpRepositoryImpl({
    required super.remoteData,
    required super.networkInfo, // For checking network connection
  });

  @override
  Future<Either> verifyOtp({required VerifyOtpRequestModel model,required bool isLogin}) async {
    if(isLogin){
      DioClient().removeHeader();
    }
    try {
      final result = await remoteData.post(
        body: model.toJson(),
        path: isLogin?ApiEndpointsConstants.verifyOtpLogin : ApiEndpointsConstants.verifyOtp,
        headers: headers,
        model: GeneralResponseModel(model:LoginResponseModel()),
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
