import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/home/data/holiday_model.dart';
import '../providers/api_provider.dart';

/// Fetches store offline/online status from GET /store-status.
/// Returns null if store is online, HolidayModel if offline.
final storeStatusProvider = FutureProvider<HolidayModel?>((ref) async {
  final api = ref.watch(apiClientProvider);
  try {
    final response = await api.get('/store-status');
    final data = response.data;
    if (data['success'] == true && data['data'] != null) {
      return HolidayModel.fromJson(
        Map<String, dynamic>.from(data['data']),
      );
    }
    return null;
  } catch (_) {
    return null;
  }
});
