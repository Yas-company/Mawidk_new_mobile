import 'package:dartz/dartz.dart';
import 'package:mawidak/core/base_network/api_endpoints_constants.dart';
import 'package:mawidak/core/base_network/general_response_model.dart';
import 'package:mawidak/core/base_network/network_repository.dart';
import 'package:mawidak/features/privacy_policy/data/model/privacy_policy_response_model.dart';
import 'package:mawidak/features/privacy_policy/domain/repository/privacy_policy_repository.dart';
import '../../../../core/base_network/error/handler/error_model.dart';
import '../../../../core/base_network/error/handler/exception_enum.dart';

class PrivacyPolicyRepositoryImpl extends MainRepository implements PrivacyPolicyRepository {
  PrivacyPolicyRepositoryImpl({
    required super.remoteData,
    required super.networkInfo, // For checking network connection
  });

  @override
  Future<Either> getPrivacyPolicy({required int id}) async{
    try {
      final result = await remoteData.get(
        path: ApiEndpointsConstants.privacyPolicy+id.toString(),
        // headers: headers,
        model: GeneralResponseModel(model: PrivacyPolicyResponseModel()),
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
