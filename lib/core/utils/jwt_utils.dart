import 'dart:convert';

class JwtUtils {
  static bool isExpired(String token) {
    try {
      final Map<String, dynamic> payload = decode(token);
      final DateTime? expirationDate = getExpirationDate(payload);
      
      if (expirationDate == null) {
        return false; // No expiration claim, assume valid (or handle as error)
      }
      
      // If the current time is AFTER the expiration date, it's expired
      return DateTime.now().isAfter(expirationDate);
    } catch (e) {
      // If we can't decode it, it's definitely invalid/expired
      return true;
    }
  }

  static Map<String, dynamic> decode(String token) {
    // JWT is just 3 Base64 strings separated by dots. We want the middle one (Payload).
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('Invalid token');
    }

    String payload = parts[1];
    
    // JWT Base64 is sometimes not padded correctly, we fix that here
    switch (payload.length % 4) {
      case 0: break;
      case 2: payload += '=='; break;
      case 3: payload += '='; break;
      default: throw Exception('Illegal base64url string!"');
    }

    return json.decode(utf8.decode(base64Url.decode(payload)));
  }

  static DateTime? getExpirationDate(Map<String, dynamic> payload) {
    final exp = payload['exp'];
    if (exp == null) return null;
    
    // 'exp' is in seconds since epoch
    return DateTime.fromMillisecondsSinceEpoch(exp * 1000);
  }
}