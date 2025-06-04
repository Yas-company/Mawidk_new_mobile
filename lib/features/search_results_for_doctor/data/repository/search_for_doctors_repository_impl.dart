import 'package:dartz/dartz.dart';
import 'package:mawidak/core/base_network/api_endpoints_constants.dart';
import 'package:mawidak/core/base_network/general_response_model.dart';
import 'package:mawidak/core/base_network/network_repository.dart';
import 'package:mawidak/features/all_patients/data/model/patients_response_model.dart';
import 'package:mawidak/features/search_results_for_doctor/domain/repository/search_for_doctors_repository.dart';
import '../../../../core/base_network/error/handler/error_model.dart';
import '../../../../core/base_network/error/handler/exception_enum.dart';

class SearchForDoctorsRepositoryImpl extends MainRepository implements SearchForDoctorsRepository {
  SearchForDoctorsRepositoryImpl({
    required super.remoteData,
    required super.networkInfo, // For checking network connection
  });

  @override
  Future<Either> searchForDoctor({required String key})async {
    try {
      final result = await remoteData.get(
        path: ApiEndpointsConstants.searchForDoctor,
        queryParameters: {'search': key},
        headers: headers,
        model: GeneralResponseModel(model:PatientsResponseModel()),
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
