import 'package:dartz/dartz.dart';
import 'package:mawidak/core/base_network/api_endpoints_constants.dart';
import 'package:mawidak/core/base_network/general_response_model.dart';
import 'package:mawidak/core/base_network/network_repository.dart';
import 'package:mawidak/features/show_file/data/model/basic_information_response_model.dart';
import 'package:mawidak/features/show_file/domain/repository/show_file_repository.dart';
import '../../../../core/base_network/error/handler/error_model.dart';
import '../../../../core/base_network/error/handler/exception_enum.dart';

class ShowFileRepositoryImpl extends MainRepository implements ShowFileRepository {
  ShowFileRepositoryImpl({
    required super.remoteData,
    required super.networkInfo,
  });

  @override
  Future<Either> getBasicInfo({required int id})async {
    try {
      final result = await remoteData.get(
        path: ApiEndpointsConstants.basicInformation+id.toString(),
        headers: headers,
        model: GeneralResponseModel(model:BasicInformationResponseModel()),
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
