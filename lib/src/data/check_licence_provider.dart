import 'dart:convert';
import 'dart:io';

import 'package:check_licence_tech/src/domain/check_licence_entity.dart';

class CheckLicenceProvider {
  CheckLicenceProvider._();
  factory CheckLicenceProvider() => CheckLicenceProvider._();

  Future<CheckLicenceEntity?> checkLicence({
    required String url,
    required String licenceKey,
    required String deviceSerialNumber,
  }) async {
    final uri = Uri.parse(url);

    final httpClient = HttpClient();
    try {
      final request = await httpClient.postUrl(uri);

      // Headers
      request.headers.set(HttpHeaders.contentTypeHeader, 'application/json');
      if (licenceKey.isNotEmpty) {
        request.headers.set(HttpHeaders.authorizationHeader, 'Bearer $licenceKey');
      }

      // Corpo da requisição
      final body = jsonEncode({
        'serialNumber': deviceSerialNumber,
      });
      request.add(utf8.encode(body));

      final response = await request.close();

      if (response.statusCode == 200) {
        final responseBody = await response.transform(utf8.decoder).join();
        final map = jsonDecode(responseBody) as Map<String, dynamic>;
        return CheckLicenceEntity.fromMap(map);
      } else {
        print('Erro na requisição: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Erro durante a requisição: $e');
      return null;
    } finally {
      httpClient.close();
    }
  }
}
