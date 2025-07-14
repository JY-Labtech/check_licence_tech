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
      print('Error: Response is null');
      throw Exception('Response is null');
    }
    if (response.isExpired || response.isInactive) {
      print('Error: Licence is expired or inactive');
      throw Exception('Licence is expired or inactive');
    }
    if (response.expiredAt.isBefore(DateTime.now())) {
      print('Error: Licence is expired');
      throw Exception('Licence is expired');
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
      print('Error: Licence is expired or inactive');
      aux = false;
    }
    if (licenceDatabase.licenceEncrypt != licenceKey) {
      print('Error: Licence key does not match');
      aux = false;
    }
    if (serialNumber != licenceDatabase.deviceSerialNumber) {
      print('Error: Device serial number does not match');
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

  Future<String> getSerialNumber() async {
    try {
      final serialNumber = await _device.getDeviceSerialNumber();
      return serialNumber;
    } catch (e) {
      rethrow;
    }
  }
}
