/// Typed wrapper for API responses matching backend format:
/// { "success": true/false, "data": ..., "message": "...", "errors": {...} }
class ApiResponse<T> {
  final bool success;
  final T? data;
  final String? message;
  final Map<String, dynamic>? errors;
  final PaginationMeta? meta;

  ApiResponse({
    required this.success,
    this.data,
    this.message,
    this.errors,
    this.meta,
  });

  factory ApiResponse.fromJson(
    Map<String, dynamic> json, {
    T Function(dynamic)? fromData,
  }) {
    return ApiResponse(
      success: json['success'] ?? false,
      data: json.containsKey('data') && fromData != null
          ? fromData(json['data'])
          : json['data'] as T?,
      message: json['message'],
      errors: json['errors'] != null
          ? Map<String, dynamic>.from(json['errors'])
          : null,
      meta: json.containsKey('meta')
          ? PaginationMeta.fromJson(json['meta'])
          : null,
    );
  }

  /// Get first error message from validation errors
  String get firstError {
    if (errors != null && errors!.isNotEmpty) {
      final firstField = errors!.values.first;
      if (firstField is List && firstField.isNotEmpty) {
        return firstField.first.toString();
      }
    }
    return message ?? 'An error occurred';
  }
}

class PaginationMeta {
  final int currentPage;
  final int lastPage;
  final int perPage;
  final int total;

  PaginationMeta({
    required this.currentPage,
    required this.lastPage,
    required this.perPage,
    required this.total,
  });

  factory PaginationMeta.fromJson(Map<String, dynamic> json) {
    return PaginationMeta(
      currentPage: json['current_page'] ?? 1,
      lastPage: json['last_page'] ?? 1,
      perPage: json['per_page'] ?? 20,
      total: json['total'] ?? 0,
    );
  }

  bool get hasMore => currentPage < lastPage;
}
