import 'dart:convert';

class StringHelper {
  String sanitizeUrl(String data) {
    if (data.contains('http')) {
      return data;
    } else {
      final decodedBytes = base64Decode(data);
      return utf8.decode(decodedBytes);
    }
  }
}
