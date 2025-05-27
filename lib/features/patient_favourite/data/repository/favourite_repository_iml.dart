import 'package:dartz/dartz.dart';
import 'package:mawidak/core/base_network/api_endpoints_constants.dart';
import 'package:mawidak/core/base_network/general_response_model.dart';
import 'package:mawidak/core/base_network/network_repository.dart';
import 'package:mawidak/features/patient_favourite/data/domain/repository/favourite_repository.dart';
import 'package:mawidak/features/patient_favourite/data/model/favourite_doctors_list_response_model.dart';
import '../../../../core/base_network/error/handler/error_model.dart';
import '../../../../core/base_network/error/handler/exception_enum.dart';

class FavouriteRepositoryIml extends MainRepository implements FavouriteRepository {
  FavouriteRepositoryIml({
    required super.remoteData,
    required super.networkInfo, // For checking network connection
  });

  @override
  Future<Either> getFavouriteDoctors() async{
    try {
      final result = await remoteData.get(
        path: ApiEndpointsConstants.favoriteDoctorList,
        headers: headers,
        model: GeneralResponseModel(model:FavouriteDoctorListResponseModel()),
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
