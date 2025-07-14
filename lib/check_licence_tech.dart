library check_licence_tech;

import 'package:check_licence_tech/src/check_licence_tech_controller.dart';

final class CheckLicenceTech {
  final _controller = CheckLicenceTechController();

  CheckLicenceTech._internal();
  static final CheckLicenceTech _instance = CheckLicenceTech._internal();
  factory CheckLicenceTech.instance() => _instance;

  Future<bool> checkLicence(
    String licenceKey, {
    required String url,
  }) async {
    return await _controller.checkLicence(licenceKey, url: url);
  }

  Future<String> getSerialNumber() async {
    return await _controller.getSerialNumber();
  }
}
