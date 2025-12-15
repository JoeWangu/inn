import 'dart:convert';

class JwtUtils {
  static bool isExpired(String token) {
    try {
      final Map<String, dynamic> payload = decode(token);
      final DateTime? expirationDate = getExpirationDate(payload);

      if (expirationDate == null) {
        return false;
      }

      return DateTime.now().isAfter(expirationDate);
    } catch (e) {
      return true;
    }
  }

  static Map<String, dynamic> decode(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('Invalid token');
    }

    String payload = parts[1];

    switch (payload.length % 4) {
      case 0:
        break;
      case 2:
        payload += '==';
        break;
      case 3:
        payload += '=';
        break;
      default:
        throw Exception('Illegal base64url string!"');
    }

    return json.decode(utf8.decode(base64Url.decode(payload)));
  }

  static DateTime? getExpirationDate(Map<String, dynamic> payload) {
    final exp = payload['exp'];
    if (exp == null) return null;

    return DateTime.fromMillisecondsSinceEpoch(exp * 1000);
  }
}
