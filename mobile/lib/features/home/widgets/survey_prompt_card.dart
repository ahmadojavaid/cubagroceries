import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/api_provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimens.dart';

final pendingSurveysProvider =
    FutureProvider<List<Map<String, dynamic>>>((ref) async {
  final api = ref.watch(apiClientProvider);
  final response = await api.get('/surveys');
  final data = response.data;
  if (data['success'] == true) {
    return List<Map<String, dynamic>>.from(data['data']);
  }
  return [];
});

/// Compact survey card that shows the first pending survey on the home screen
class SurveyPromptCard extends ConsumerStatefulWidget {
  const SurveyPromptCard({super.key});

  @override
  ConsumerState<SurveyPromptCard> createState() => _SurveyPromptCardState();
}

class _SurveyPromptCardState extends ConsumerState<SurveyPromptCard> {
  bool _dismissed = false;
  bool _submitting = false;

  Future<void> _respond(int surveyId, String answer) async {
    setState(() => _submitting = true);
    try {
      final api = ref.read(apiClientProvider);
      await api.post('/surveys/$surveyId/respond', data: {'answer': answer});
      if (!mounted) return;
      ref.invalidate(pendingSurveysProvider);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Thanks for your feedback!')),
      );
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Could not submit response'),
          backgroundColor: AppColors.error,
        ),
      );
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_dismissed) return const SizedBox.shrink();

    final surveysAsync = ref.watch(pendingSurveysProvider);

    return surveysAsync.when(
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
      data: (surveys) {
        if (surveys.isEmpty) return const SizedBox.shrink();

        final survey = surveys.first;
        final options = List<String>.from(survey['options'] ?? []);
        final surveyId = survey['id'] as int;

        return Container(
          margin: const EdgeInsets.only(bottom: AppDimens.md),
          padding: const EdgeInsets.all(AppDimens.md),
          decoration: BoxDecoration(
            color: AppColors.info.withOpacity(0.06),
            borderRadius: BorderRadius.circular(AppDimens.radiusMd),
            border: Border.all(color: AppColors.info.withOpacity(0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.poll_outlined,
                      size: 18, color: AppColors.info),
                  const SizedBox(width: 6),
                  const Expanded(
                    child: Text(
                      'Quick Survey',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                        color: AppColors.info,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => setState(() => _dismissed = true),
                    child: const Icon(Icons.close,
                        size: 18, color: AppColors.textHint),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                survey['question'] ?? '',
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 10),
              if (_submitting)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                )
              else
                Wrap(
                  spacing: 8,
                  runSpacing: 6,
                  children: options
                      .map((option) => InkWell(
                            onTap: () => _respond(surveyId, option),
                            borderRadius:
                                BorderRadius.circular(AppDimens.radiusFull),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 14, vertical: 8),
                              decoration: BoxDecoration(
                                color: AppColors.cardBg,
                                borderRadius: BorderRadius.circular(
                                    AppDimens.radiusFull),
                                border: Border.all(
                                    color: AppColors.border, width: 0.5),
                              ),
                              child: Text(
                                option,
                                style: const TextStyle(fontSize: 13),
                              ),
                            ),
                          ))
                      .toList(),
                ),
            ],
          ),
        );
      },
    );
  }
}
