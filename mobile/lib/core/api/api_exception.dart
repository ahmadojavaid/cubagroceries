/// API error types for clean error handling in UI
class ApiException implements Exception {
  final String message;
  final int? statusCode;
  final Map<String, dynamic>? errors;

  ApiException({
    required this.message,
    this.statusCode,
    this.errors,
  });

  /// Get first validation error
  String get firstError {
    if (errors != null && errors!.isNotEmpty) {
      final firstField = errors!.values.first;
      if (firstField is List && firstField.isNotEmpty) {
        return firstField.first.toString();
      }
    }
    return message;
  }

  bool get isValidation => statusCode == 422;
  bool get isUnauthorized => statusCode == 401;
  bool get isNotFound => statusCode == 404;
  bool get isRateLimited => statusCode == 429;
  bool get isServerError => statusCode != null && statusCode! >= 500;

  @override
  String toString() => message;
}
