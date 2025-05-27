abstract class NotificationEvent {
  const NotificationEvent();
}

class ApplyNotificationById extends NotificationEvent {
  final int id;
  const ApplyNotificationById({required this.id}) : super();
}

class ApplyGetNotificationEvent extends NotificationEvent {
  const ApplyGetNotificationEvent() : super();
}

