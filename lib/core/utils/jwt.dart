import 'dart:convert';

/// Decodes the payload (claims) of a JWT **without verifying its signature**.
///
/// The PathFinder access token payload contains `userId`, `email` and `role`.
/// Returns `null` if the token is missing or malformed.
Map<String, dynamic>? decodeJwtPayload(String? token) {
  if (token == null || token.isEmpty) return null;

  final parts = token.split('.');
  if (parts.length != 3) return null;

  try {
    var payload = parts[1].replaceAll('-', '+').replaceAll('_', '/');
    switch (payload.length % 4) {
      case 2:
        payload += '==';
        break;
      case 3:
        payload += '=';
        break;
    }
    final decoded = utf8.decode(base64.decode(payload));
    final map = jsonDecode(decoded);
    return map is Map<String, dynamic> ? map : null;
  } catch (_) {
    return null;
  }
}

/// Convenience accessor for the `email` claim in the access token.
String? emailFromToken(String? token) {
  final value = decodeJwtPayload(token)?['email'];
  return value is String && value.trim().isNotEmpty ? value.trim() : null;
}
