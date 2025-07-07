import 'package:check_licence_tech/src/data/check_device_provider.dart';
import 'package:check_licence_tech/src/data/check_storage_provider.dart';

import '../src/data/check_licence_provider.dart';

class CheckLicenceTechController {
  final _provider = CheckLicenceProvider();
  final _storage = CheckStorageProvider();
  final _device = CheckDeviceProvider();

  Future<bool> checkLicence(
    String licenceKey, {
    required String url,
  }) async {
    try {
      final hasLicence = await _storage.containsLicence();
      final serialNumber = await _device.getDeviceSerialNumber();
      if (!hasLicence) {
        return await _getLicenceFromServer(licenceKey, serialNumber: serialNumber, url: url);
      }
      return await _getLicenceDatabase(licenceKey, serialNumber: serialNumber, url: url);
    } catch (e) {
      return false;
    }
  }

  Future<bool> _getLicenceFromServer(
    String licenceKey, {
    required String serialNumber,
    required String url,
  }) async {
    final response = await _provider.checkLicence(
      licenceKey: licenceKey,
      deviceSerialNumber: serialNumber,
      url: url,
    );
    if (response == null) {
      return false;
    }
    if (response.isExpired || response.isInactive) {
      return false;
    }
    if (response.expiredAt.isBefore(DateTime.now())) {
      return false;
    }
    await _storage.insert(entity: response);
    return true;
  }

  Future<bool> _getLicenceDatabase(
    String licenceKey, {
    required String serialNumber,
    required String url,
  }) async {
    bool aux = false;
    final licenceDatabase = await _storage.getLicence();
    if (licenceDatabase == null) {
      return false;
    }
    if (licenceDatabase.expiredAt.isAfter(DateTime.now())) {
      aux = true;
    }
    if (licenceDatabase.isExpired || licenceDatabase.isInactive) {
      aux = false;
    }
    if (licenceDatabase.licenceEncrypt != licenceKey) {
      aux = false;
    }
    if (serialNumber != licenceDatabase.deviceSerialNumber) {
      aux = false;
    }
    if (!aux) {
      return await _getLicenceFromServer(
        licenceKey,
        serialNumber: serialNumber,
        url: url,
      );
    }

    return true;
  }
}
