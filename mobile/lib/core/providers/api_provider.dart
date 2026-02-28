import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../api/api_client.dart';

/// Single ApiClient instance shared across the app
final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient();
});
