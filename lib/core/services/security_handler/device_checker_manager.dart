import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_security_checker/flutter_security_checker.dart';

class DeviceCheckerManager {
  // Check whether the device is rooted or jailBroken.
  // In Android Emulator or iOS Simulator it always returns true.
  isRootedDevice() async {
    final bool isRooted = await FlutterSecurityChecker.isRooted;
    if (isRooted) {
      closeApp();
    }
  }

  // Check whether the device on which the app is installed is a physical device.
  isRealDevice() async {
    final bool isRealDevice = await FlutterSecurityChecker.isRealDevice;
    if (!isRealDevice) {
      closeApp();
    }
  }

  // Check that the app is installed through the correct content service (such as Google Play or Apple Store).
  // It is not an app installed through content service or always returns false in debugging mode.
  hasCorrectlyInstalled() async {
    final bool hasCorrectlyInstalled =
        await FlutterSecurityChecker.hasCorrectlyInstalled;
    if (!hasCorrectlyInstalled) {
      closeApp();
    }
  }

  void closeApp() {
    if (Platform.isAndroid) {
      SystemNavigator.pop();
    } else if (Platform.isIOS) {
      exit(0);
    }
  }
}
