import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../domain/check_licence_entity.dart';

final class CheckStorageProvider {
  CheckStorageProvider._internal();
  static final CheckStorageProvider _instance = CheckStorageProvider._internal();
  factory CheckStorageProvider() => _instance;

  final _storage = const FlutterSecureStorage();

  Future<bool> insert({required CheckLicenceEntity entity}) async {
    try {
      await _storage.write(key: 'licence_key', value: entity.toJson());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<CheckLicenceEntity?> getLicence() async {
    try {
      final json = await _storage.read(key: 'licence_key');
      if (json == null) return null;
      return CheckLicenceEntity.fromJson(json);
    } catch (e) {
      return null;
    }
  }

  Future<bool> deleteLicence() async {
    try {
      await _storage.delete(key: 'licence_key');
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> containsLicence() async {
    try {
      return await _storage.containsKey(key: 'licence_key');
    } catch (e) {
      return false;
    }
  }
}
