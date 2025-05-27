import 'package:dartz/dartz.dart';
import 'package:mawidak/core/base_network/api_endpoints_constants.dart';
import 'package:mawidak/core/base_network/general_response_model.dart';
import 'package:mawidak/core/base_network/network_repository.dart';
import 'package:mawidak/features/doctor_profile/data/model/doctor_profile_response_model.dart';
import 'package:mawidak/features/doctor_profile/data/model/favourite_request_model.dart';
import 'package:mawidak/features/doctor_profile/data/model/favourite_response_model.dart';
import 'package:mawidak/features/doctor_profile/domain/repository/doctor_profile_repository.dart';
import '../../../../core/base_network/error/handler/error_model.dart';
import '../../../../core/base_network/error/handler/exception_enum.dart';

class DoctorProfileRepositoryImpl extends MainRepository implements DoctorProfileRepository {
  DoctorProfileRepositoryImpl({
    required super.remoteData,
    required super.networkInfo,
  });

  @override
  Future<Either> getDoctorProfile({required int id})async {
    try {
      final result = await remoteData.get(
        path: ApiEndpointsConstants.doctorDetails+id.toString(),
        headers: headers,
        model: GeneralResponseModel(model:DoctorProfileResponseModel()),
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

  @override
  Future<Either> addToFavourite({required FavouriteRequestModel model})async {
    try {
      final result = await remoteData.post(
        body:model.toJson(),
        path: ApiEndpointsConstants.addToFavourite,
        headers: headers,
        model: GeneralResponseModel(model:FavouriteResponseModel()),
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
