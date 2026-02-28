import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/api_provider.dart';
import '../../../core/theme/app_dimens.dart';
import '../../../core/widgets/shared_widgets.dart';

final appSettingsProvider =
    FutureProvider<Map<String, dynamic>>((ref) async {
  final api = ref.watch(apiClientProvider);
  final response = await api.get('/settings');
  final data = response.data;
  if (data['success'] == true) {
    return Map<String, dynamic>.from(data['data']);
  }
  return {};
});

class LegalPageScreen extends StatelessWidget {
  final String title;
  final String settingsKey;

  const LegalPageScreen({
    super.key,
    required this.title,
    required this.settingsKey,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Consumer(
        builder: (context, ref, _) {
          final settingsAsync = ref.watch(appSettingsProvider);

          return settingsAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, _) => ErrorStateWidget(
              message: 'Failed to load content',
              onRetry: () => ref.invalidate(appSettingsProvider),
            ),
            data: (settings) {
              final content = settings[settingsKey] as String? ?? '';
              // Strip basic HTML tags for display
              final cleanText = content
                  .replaceAll(RegExp(r'<[^>]*>'), '')
                  .trim();

              return cleanText.isEmpty
                  ? const EmptyStateWidget(
                      icon: Icons.article_outlined,
                      message: 'Content not available yet',
                    )
                  : SingleChildScrollView(
                      padding: const EdgeInsets.all(AppDimens.pagePadding),
                      child: Text(
                        cleanText,
                        style: const TextStyle(fontSize: 14, height: 1.6),
                      ),
                    );
            },
          );
        },
      ),
    );
  }
}
