import 'dart:io';

abstract class LogoutEvent {
  const LogoutEvent();
}

class MakeLogoutEvent extends LogoutEvent {
  const MakeLogoutEvent() : super();
}
class MakeDeleteAccount extends LogoutEvent {
  const MakeDeleteAccount() : super();
}

class UpdatePhotoEvent extends LogoutEvent {
  final File file;
  const UpdatePhotoEvent({required this.file}) : super();
}