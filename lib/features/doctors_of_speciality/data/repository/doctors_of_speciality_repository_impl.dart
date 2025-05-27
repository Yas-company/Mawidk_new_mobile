import 'package:dartz/dartz.dart';
import 'package:mawidak/core/base_network/api_endpoints_constants.dart';
import 'package:mawidak/core/base_network/general_response_model.dart';
import 'package:mawidak/core/base_network/network_repository.dart';
import 'package:mawidak/features/doctors_of_speciality/domain/repository/doctors_of_speciality_repository.dart';
import 'package:mawidak/features/home/data/model/doctors_for_patient_response_model.dart';
import '../../../../core/base_network/error/handler/error_model.dart';
import '../../../../core/base_network/error/handler/exception_enum.dart';

class DoctorsOfSpecialityRepositoryImpl extends MainRepository implements DoctorsOfSpecialityRepository {
  DoctorsOfSpecialityRepositoryImpl({
    required super.remoteData,
    required super.networkInfo, // For checking network connection
  });

  @override
  Future<Either> getDoctors({required int id}) async {
    try {
      final result = await remoteData.get(
        path: ApiEndpointsConstants.doctorsBySpeciality+id.toString(),
        headers: headers,
        model: GeneralResponseModel(model:DoctorsForPatientResponseModel()),
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
