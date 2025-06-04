import 'package:dartz/dartz.dart';
import 'package:mawidak/core/base_network/api_endpoints_constants.dart';
import 'package:mawidak/core/base_network/general_response_model.dart';
import 'package:mawidak/core/base_network/network_repository.dart';
import 'package:mawidak/features/all_patients/data/model/patients_response_model.dart';
import 'package:mawidak/features/all_patients/domain/repository/patients_repository.dart';
import '../../../../core/base_network/error/handler/error_model.dart';
import '../../../../core/base_network/error/handler/exception_enum.dart';

class PatientsRepositoryImpl extends MainRepository implements PatientsRepository {
  PatientsRepositoryImpl({
    required super.remoteData,
    required super.networkInfo, // For checking network connection
  });

  @override
  Future<Either> getDoctorPatients() async {
    try {
      final result = await remoteData.get(
        path: ApiEndpointsConstants.doctorPatients,
        headers: headers,
        model: GeneralResponseModel(model: PatientsResponseModel()),
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
