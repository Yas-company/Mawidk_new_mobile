import 'package:dartz/dartz.dart';
import 'package:mawidak/core/base_network/api_endpoints_constants.dart';
import 'package:mawidak/core/base_network/general_response_model.dart';
import 'package:mawidak/core/base_network/network_repository.dart';
import 'package:mawidak/features/lookups/cities_response_model.dart';
import 'package:mawidak/features/lookups/lookup_repository.dart';
import '../../../../core/base_network/error/handler/error_model.dart';
import '../../../../core/base_network/error/handler/exception_enum.dart';

class LookupRepositoryImpl extends MainRepository implements LookupRepository {
  LookupRepositoryImpl({
    required super.remoteData,
    required super.networkInfo, // For checking network connection
  });

  @override
  Future<Either> fetchCities()async {
    try {
      final result = await remoteData.get(
        path: ApiEndpointsConstants.cities,
        headers: headers,
        model: GeneralResponseModel(model:CitiesResponseModel()),
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
