import 'package:dartz/dartz.dart';
import 'package:mawidak/features/notification/domain/repository/notification_repository.dart';

class NotificationUseCase {
  final NotificationRepository notificationRepository;

  NotificationUseCase({required this.notificationRepository});

  Future<Either> getNotification() async {
    return await notificationRepository.getNotification();
  }

  Future<Either> getNotificationById({required int id}) async {
    return await notificationRepository.getNotificationById(id: id);
  }

}
