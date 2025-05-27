import 'dart:io';

import 'package:permission_handler/permission_handler.dart';

Future<bool> checkCameraPermission() async {
  PermissionStatus status = await Permission.camera.status;
  if (status.isGranted) {
    return true;
  } else {
    PermissionStatus permissionStatus = await Permission.camera.request();
    if (permissionStatus.isGranted) {
      return true;
    } else {
      await openAppSettings();
      return false;
    }
  }
}

Future<bool> checkGalleryPermission() async {
  if (!Platform.isIOS &&
      Platform.isAndroid &&
      int.parse(Platform.version.split('.')[0]) <= 12) {
    return true;
  } else {
    PermissionStatus status = await Permission.photos.status;
    if (status.isGranted) {
      return true;
    } else {
      PermissionStatus permissionStatus = await Permission.photos.request();
      if (permissionStatus.isGranted) {
        return true;
      } else {
        return false;
      }
    }
  }
}
