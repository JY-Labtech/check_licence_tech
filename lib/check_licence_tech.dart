library check_licence_tech;

import 'package:check_licence_tech/src/check_licence_tech_controller.dart';

class CheckLicenceTech {
  final _controller = CheckLicenceTechController();

  Future<bool> checkLicence(
    String licenceKey, {
    required String url,
  }) async {
    return await _controller.checkLicence(licenceKey, url: url);
  }
}
