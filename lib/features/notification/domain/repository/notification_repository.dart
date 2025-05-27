import 'package:dartz/dartz.dart';

abstract class NotificationRepository {
  Future<Either<dynamic, dynamic>> getNotification();
  Future<Either<dynamic, dynamic>> getNotificationById({required int id});
}
