import 'package:dartz/dartz.dart';
import 'package:mawidak/core/base_network/api_endpoints_constants.dart';
import 'package:mawidak/core/base_network/general_response_model.dart';
import 'package:mawidak/core/base_network/network_repository.dart';
import 'package:mawidak/features/notification/data/model/notification_response_model.dart';
import 'package:mawidak/features/notification/domain/repository/notification_repository.dart';
import '../../../../core/base_network/error/handler/error_model.dart';
import '../../../../core/base_network/error/handler/exception_enum.dart';

class NotificationRepositoryImpl extends MainRepository implements NotificationRepository {
  NotificationRepositoryImpl({
    required super.remoteData,
    required super.networkInfo, // For checking network connection
  });

  @override
  Future<Either> getNotification() async {
    try {
      final result = await remoteData.get(
        path: ApiEndpointsConstants.notification,
        headers: headers,
        model: GeneralResponseModel(model:NotificationResponseModel()),
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

  @override
  Future<Either> getNotificationById({required int id}) async {
    try {
      final result = await remoteData.get(
        path: ApiEndpointsConstants.notificationById+id.toString(),
        headers: headers,
        model: GeneralResponseModel(model:NotificationModel()),
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
