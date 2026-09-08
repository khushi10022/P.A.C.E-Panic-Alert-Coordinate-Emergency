// SheShield – Custom Exceptions
//
// Application-specific exception types for granular error handling.

class ServerException implements Exception {
  final String message;
  final int? statusCode;

  const ServerException({
    this.message = 'Server error occurred',
    this.statusCode,
  });

  @override
  String toString() => 'ServerException: $message (code: $statusCode)';
}

class CacheException implements Exception {
  final String message;

  const CacheException({this.message = 'Cache error occurred'});

  @override
  String toString() => 'CacheException: $message';
}

class AuthException implements Exception {
  final String message;
  final String? code;

  const AuthException({
    this.message = 'Authentication error',
    this.code,
  });

  @override
  String toString() => 'AuthException: $message (code: $code)';
}

class BluetoothException implements Exception {
  final String message;

  const BluetoothException({this.message = 'Bluetooth error occurred'});

  @override
  String toString() => 'BluetoothException: $message';
}

class LocationException implements Exception {
  final String message;

  const LocationException({this.message = 'Location error occurred'});

  @override
  String toString() => 'LocationException: $message';
}

class NetworkException implements Exception {
  final String message;

  const NetworkException({this.message = 'Network error occurred'});

  @override
  String toString() => 'NetworkException: $message';
}

class PermissionException implements Exception {
  final String message;

  const PermissionException({this.message = 'Permission denied'});

  @override
  String toString() => 'PermissionException: $message';
}
