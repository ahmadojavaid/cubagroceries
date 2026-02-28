import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../api/api_client.dart';
import '../providers/api_provider.dart';
import '../services/fcm_service.dart';

/// Provider for the FCM service. Call initialize() after user logs in.
final fcmServiceProvider = Provider<FcmService>((ref) {
  final api = ref.watch(apiClientProvider);
  return FcmService(api);
});
