import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/api_provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimens.dart';
import '../../../core/widgets/shared_widgets.dart';

final faqsProvider = FutureProvider<List<Map<String, dynamic>>>((ref) async {
  final api = ref.watch(apiClientProvider);
  final response = await api.get('/faqs');
  final data = response.data;
  if (data['success'] == true) {
    return List<Map<String, dynamic>>.from(data['data']);
  }
  return [];
});

class FaqScreen extends ConsumerWidget {
  const FaqScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final faqsAsync = ref.watch(faqsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('FAQs')),
      body: faqsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => ErrorStateWidget(
          message: 'Failed to load FAQs',
          onRetry: () => ref.invalidate(faqsProvider),
        ),
        data: (faqs) => faqs.isEmpty
            ? const EmptyStateWidget(
                icon: Icons.help_outline,
                message: 'No FAQs available',
              )
            : ListView.builder(
                padding: const EdgeInsets.all(AppDimens.pagePadding),
                itemCount: faqs.length,
                itemBuilder: (context, index) {
                  final faq = faqs[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: AppDimens.sm),
                    child: ExpansionTile(
                      title: Text(
                        faq['question'] ?? '',
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      children: [
                        Text(
                          faq['answer'] ?? '',
                          style: TextStyle(
                            fontSize: 13,
                            color: AppColors.textSecondary,
                            height: 1.5,
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
}
