import 'package:dartz/dartz.dart';
import 'package:mawidak/core/base_network/api_endpoints_constants.dart';
import 'package:mawidak/core/base_network/general_response_model.dart';
import 'package:mawidak/core/base_network/network_repository.dart';
import 'package:mawidak/features/patient_evaluation/data/model/add_rate_request_model.dart';
import 'package:mawidak/features/patient_evaluation/domain/repository/patient_evaluation_repository.dart';
import '../../../../core/base_network/error/handler/error_model.dart';
import '../../../../core/base_network/error/handler/exception_enum.dart';

class PatientEvaluationRepositoryImpl extends MainRepository implements PatientEvaluationRepository {
  PatientEvaluationRepositoryImpl({
    required super.remoteData,
    required super.networkInfo, // For checking network connection
  });


  @override
  Future<Either> addRate({required AddRateRequestModel model}) async {
    try {
      final result = await remoteData.post(
        body:model.toJson(),
        path: ApiEndpointsConstants.addRate,
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
