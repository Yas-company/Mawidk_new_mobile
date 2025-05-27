import 'package:dartz/dartz.dart';
import 'package:mawidak/core/base_network/api_endpoints_constants.dart';
import 'package:mawidak/core/base_network/general_response_model.dart';
import 'package:mawidak/core/base_network/network_repository.dart';
import 'package:mawidak/features/search/data/model/filter_request_model.dart';
import 'package:mawidak/features/search/data/model/search_map_request_model.dart';
import 'package:mawidak/features/search/data/model/search_map_response_model.dart';
import 'package:mawidak/features/search/data/model/search_response_model.dart';
import 'package:mawidak/features/search/domain/repository/search_respository.dart';
import '../../../../core/base_network/error/handler/error_model.dart';
import '../../../../core/base_network/error/handler/exception_enum.dart';

class SearchRepositoryImpl extends MainRepository implements SearchRepository {
  SearchRepositoryImpl({
    required super.remoteData,
    required super.networkInfo, // For checking network connection
  });

  @override
  Future<Either> searchForPatient({required String key})async {
    try {
      final result = await remoteData.get(
        path: ApiEndpointsConstants.searchForPatient,
        queryParameters: {'search': key},
        headers: headers,
        model: GeneralResponseModel(model:SearchResponseModel()),
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
  Future<Either> searchMap({required SearchMapRequestModel model})async {
    // print('model>>'+model.latitude.toString());
    // print('model>>'+model.longitude.toString());
    try {
      final result = await remoteData.get(
        body:model.toJson(),
        path: ApiEndpointsConstants.searchMap,
        headers: headers,
        model: GeneralResponseModel(model:SearchMapResponseModel()),
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
  Future<Either> filter({required FilterRequestModel model})async {
    try {
      final result = await remoteData.get(
        body:model.toJson(),
        path: ApiEndpointsConstants.filter,
        headers: headers,
        model: GeneralResponseModel(model:SearchResponseModel()),
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
