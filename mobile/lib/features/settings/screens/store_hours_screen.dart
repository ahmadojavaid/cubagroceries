import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/api_provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimens.dart';
import '../../../core/widgets/shared_widgets.dart';

final storeScheduleProvider =
    FutureProvider<List<Map<String, dynamic>>>((ref) async {
  final api = ref.watch(apiClientProvider);
  final response = await api.get('/store-schedules');
  final data = response.data;
  if (data['success'] == true) {
    return List<Map<String, dynamic>>.from(data['data']);
  }
  return [];
});

class StoreHoursScreen extends ConsumerWidget {
  const StoreHoursScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheduleAsync = ref.watch(storeScheduleProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Store Hours')),
      body: scheduleAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => ErrorStateWidget(
          message: 'Failed to load store hours',
          onRetry: () => ref.invalidate(storeScheduleProvider),
        ),
        data: (schedules) => schedules.isEmpty
            ? const EmptyStateWidget(
                icon: Icons.schedule,
                message: 'No schedule available',
              )
            : ListView.builder(
                padding: const EdgeInsets.all(AppDimens.pagePadding),
                itemCount: schedules.length,
                itemBuilder: (context, index) {
                  final s = schedules[index];
                  final isClosed = s['is_closed'] == true;
                  final dayName = (s['day'] as String?)?.replaceFirst(
                        s['day']![0],
                        s['day']![0].toUpperCase(),
                      ) ??
                      '';

                  return Container(
                    margin: const EdgeInsets.only(bottom: AppDimens.xs),
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppDimens.md, vertical: 14),
                    decoration: BoxDecoration(
                      color: AppColors.cardBg,
                      borderRadius:
                          BorderRadius.circular(AppDimens.radiusSm),
                      border: Border.all(color: AppColors.border, width: 0.5),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            dayName,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        Text(
                          isClosed
                              ? 'Closed'
                              : '${_formatTime(s['open_time'])} – ${_formatTime(s['close_time'])}',
                          style: TextStyle(
                            fontSize: 14,
                            color: isClosed
                                ? AppColors.error
                                : AppColors.textSecondary,
                            fontWeight:
                                isClosed ? FontWeight.w600 : FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }

  String _formatTime(String? time) {
    if (time == null) return '';
    // time comes as "HH:mm" or "HH:mm:ss"
    final parts = time.split(':');
    if (parts.length < 2) return time;
    var hour = int.tryParse(parts[0]) ?? 0;
    final minute = parts[1];
    final amPm = hour >= 12 ? 'PM' : 'AM';
    if (hour > 12) hour -= 12;
    if (hour == 0) hour = 12;
    return '$hour:$minute $amPm';
  }
}
