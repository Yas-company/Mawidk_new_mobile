import 'package:dartz/dartz.dart';
import 'package:mawidak/core/base_network/api_endpoints_constants.dart';
import 'package:mawidak/core/base_network/general_response_model.dart';
import 'package:mawidak/core/base_network/network_repository.dart';
import 'package:mawidak/features/doctor_ratings/data/model/doctor_ratings_response_model.dart';
import 'package:mawidak/features/doctor_ratings/domain/repository/doctor_ratings_repository.dart';
import '../../../../core/base_network/error/handler/error_model.dart';
import '../../../../core/base_network/error/handler/exception_enum.dart';

class DoctorRatingsRepositoryImpl extends MainRepository implements DoctorRatingsRepository {
  DoctorRatingsRepositoryImpl({
    required super.remoteData,
    required super.networkInfo, // For checking network connection
  });

  @override
  Future<Either> getDoctorRatingsById({required int id}) async{
    try {
      final result = await remoteData.get(
        path: ApiEndpointsConstants.doctorRatingsById+id.toString(),
        headers: headers,
        model: GeneralResponseModel(model:DoctorRatingsResponseModel()),
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
