import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

class CheckDeviceProvider {
  final _deviceInfo = DeviceInfoPlugin();

  Future<String> getDeviceUid() async {
    try {
      if (Platform.isAndroid) {
        final androidInfo = await _deviceInfo.androidInfo;
        return androidInfo.id;
      } else if (Platform.isIOS) {
        final iosInfo = await _deviceInfo.iosInfo;
        return iosInfo.identifierForVendor ?? ''; // Unique ID for iOS devices
      } else {
        throw UnsupportedError('Unsupported platform');
      }
    } catch (e) {
      print('Error getting device UID: $e');
      return '';
    }
  }

  Future<String> getDeviceSerialNumber() async {
    try {
      if (Platform.isAndroid) {
        final androidInfo = await _deviceInfo.androidInfo;
        return androidInfo.serialNumber; // Serial number for Android devices
      } else if (Platform.isIOS) {
        final iosInfo = await _deviceInfo.iosInfo;
        return iosInfo.systemName; // Serial number for iOS devices
      } else {
        throw UnsupportedError('Unsupported platform');
      }
    } catch (e) {
      print('Error getting device serial number: $e');
      return '';
    }
  }
}
