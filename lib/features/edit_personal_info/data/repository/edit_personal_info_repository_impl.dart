import 'package:dartz/dartz.dart';
import 'package:mawidak/core/base_network/api_endpoints_constants.dart';
import 'package:mawidak/core/base_network/general_response_model.dart';
import 'package:mawidak/core/base_network/network_repository.dart';
import 'package:mawidak/features/edit_personal_info/data/model/edit_personal_info_request_model.dart';
import 'package:mawidak/features/edit_personal_info/data/model/profile_response_model.dart';
import 'package:mawidak/features/edit_personal_info/domain/repository/edit_personal_info_repository.dart';
import '../../../../core/base_network/error/handler/error_model.dart';
import '../../../../core/base_network/error/handler/exception_enum.dart';

class EditPersonalInfoRepositoryImpl extends MainRepository implements EditPersonalInfoRepository {
  EditPersonalInfoRepositoryImpl({
    required super.remoteData,
    required super.networkInfo,
  });

  @override
  Future<Either> editProfile({required EditPersonalInfoRequestModel model}) async {
    try {
      final result = await remoteData.put(
        body:model.toJson(),
        path: ApiEndpointsConstants.editProfile,
        headers: headers,
        model: GeneralResponseModel(model:null),
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
  Future<Either> getProfile() async {
    try {
      final result = await remoteData.get(
        path: ApiEndpointsConstants.getProfile,
        headers: headers,
        model: GeneralResponseModel(model:ProfileResponseModel()),
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
