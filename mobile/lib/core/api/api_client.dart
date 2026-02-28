import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'api_exception.dart';

/// Dio API client with token interceptor and error handling
class ApiClient {
  static const String baseUrl = 'https://cubagroceries.test/api/v1';
  static const String tokenKey = 'auth_token';

  final Dio _dio;
  final FlutterSecureStorage _storage;

  ApiClient({FlutterSecureStorage? storage})
      : _storage = storage ?? const FlutterSecureStorage(),
        _dio = Dio(BaseOptions(
          baseUrl: baseUrl,
          connectTimeout: const Duration(seconds: 15),
          receiveTimeout: const Duration(seconds: 15),
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          },
        )) {
    _dio.interceptors.addAll([
      _authInterceptor(),
      _errorInterceptor(),
    ]);
  }

  // -- Interceptors --

  InterceptorsWrapper _authInterceptor() {
    return InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await _storage.read(key: tokenKey);
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        handler.next(options);
      },
    );
  }

  InterceptorsWrapper _errorInterceptor() {
    return InterceptorsWrapper(
      onError: (error, handler) {
        final response = error.response;

        if (response != null) {
          final data = response.data;
          final message = data is Map
              ? (data['message'] ?? _statusMessage(response.statusCode))
              : _statusMessage(response.statusCode);
          final errors = data is Map && data.containsKey('errors')
              ? Map<String, dynamic>.from(data['errors'])
              : null;

          handler.reject(DioException(
            requestOptions: error.requestOptions,
            response: error.response,
            error: ApiException(
              message: message,
              statusCode: response.statusCode,
              errors: errors,
            ),
          ));
        } else {
          // Network error (no response)
          handler.reject(DioException(
            requestOptions: error.requestOptions,
            error: ApiException(
              message: _connectionErrorMessage(error),
            ),
          ));
        }
      },
    );
  }

  String _statusMessage(int? code) {
    return switch (code) {
      401 => 'Session expired. Please log in again.',
      403 => 'You do not have permission to perform this action.',
      404 => 'Resource not found.',
      422 => 'Validation failed.',
      429 => 'Too many requests. Please try again later.',
      >= 500 => 'Server error. Please try again later.',
      _ => 'Something went wrong.',
    };
  }

  String _connectionErrorMessage(DioException error) {
    return switch (error.type) {
      DioExceptionType.connectionTimeout => 'Connection timed out.',
      DioExceptionType.receiveTimeout => 'Server took too long to respond.',
      DioExceptionType.connectionError => 'No internet connection.',
      _ => 'Connection error. Please check your network.',
    };
  }

  // -- Token Management --

  Future<void> saveToken(String token) async {
    await _storage.write(key: tokenKey, value: token);
  }

  Future<void> clearToken() async {
    await _storage.delete(key: tokenKey);
  }

  Future<String?> getToken() async {
    return _storage.read(key: tokenKey);
  }

  Future<bool> hasToken() async {
    final token = await _storage.read(key: tokenKey);
    return token != null && token.isNotEmpty;
  }

  // -- HTTP Methods --

  Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) {
    return _dio.get(path, queryParameters: queryParameters);
  }

  Future<Response> post(String path, {dynamic data}) {
    return _dio.post(path, data: data);
  }

  Future<Response> put(String path, {dynamic data}) {
    return _dio.put(path, data: data);
  }

  Future<Response> delete(String path) {
    return _dio.delete(path);
  }
}
