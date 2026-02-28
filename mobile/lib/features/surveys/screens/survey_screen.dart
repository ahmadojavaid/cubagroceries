import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/providers/api_provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimens.dart';
import '../../../core/widgets/shared_widgets.dart';
import '../data/survey_model.dart';
import '../providers/survey_provider.dart';

class SurveyScreen extends ConsumerStatefulWidget {
  final int surveyId;

  const SurveyScreen({super.key, required this.surveyId});

  @override
  ConsumerState<SurveyScreen> createState() => _SurveyScreenState();
}

class _SurveyScreenState extends ConsumerState<SurveyScreen> {
  // answers[questionId] = "selected option" | ["opt1","opt2"] | "free text"
  final Map<String, dynamic> _answers = {};
  bool _submitting = false;

  Future<void> _submit(SurveyDetail survey) async {
    // Validate required
    for (final q in survey.questions) {
      if (q.isRequired) {
        final answer = _answers[q.id.toString()];
        if (answer == null ||
            (answer is String && answer.isEmpty) ||
            (answer is List && answer.isEmpty)) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Please answer: "${q.question}"'),
              backgroundColor: AppColors.error,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
          );
          return;
        }
      }
    }

    setState(() => _submitting = true);

    try {
      final api = ref.read(apiClientProvider);
      await api.post('/surveys/${widget.surveyId}/respond', data: {
        'answers': _answers,
      });

      if (!mounted) return;

      // Refresh pending surveys on home
      ref.invalidate(pendingSurveysProvider);

      // Show success & go back
      _showSuccessDialog();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Failed to submit survey. Please try again.'),
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.success.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check_circle_rounded,
                  size: 48,
                  color: AppColors.success,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Thank You!',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Your responses have been submitted.\nWe appreciate your feedback!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                    context.pop();
                  },
                  child: const Text('Done'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final surveyAsync = ref.watch(surveyDetailProvider(widget.surveyId));

    return Scaffold(
      appBar: AppBar(title: const Text('Survey')),
      body: surveyAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, __) => ErrorStateWidget(
          message: 'Could not load survey',
          onRetry: () => ref.invalidate(surveyDetailProvider(widget.surveyId)),
        ),
        data: (survey) {
          if (survey == null) {
            return const EmptyStateWidget(
              icon: Icons.assignment_late_outlined,
              message: 'Survey not available',
            );
          }
          return _buildSurvey(survey);
        },
      ),
    );
  }

  Widget _buildSurvey(SurveyDetail survey) {
    final answeredCount = _answers.entries
        .where((e) {
          final v = e.value;
          if (v is String) return v.isNotEmpty;
          if (v is List) return v.isNotEmpty;
          return false;
        })
        .length;

    return Column(
      children: [
        // Scrollable content
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(AppDimens.pagePadding),
            children: [
              // Header
              Text(
                survey.title,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
              ),
              if (survey.description != null) ...[
                const SizedBox(height: 6),
                Text(
                  survey.description!,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                    height: 1.5,
                  ),
                ),
              ],
              const SizedBox(height: 6),
              Text(
                '${survey.questions.length} questions · $answeredCount answered',
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.textHint,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 24),

              // Progress bar
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: survey.questions.isEmpty
                      ? 0
                      : answeredCount / survey.questions.length,
                  backgroundColor: AppColors.border,
                  color: AppColors.primary,
                  minHeight: 4,
                ),
              ),
              const SizedBox(height: 24),

              // Questions
              ...survey.questions.asMap().entries.map((entry) {
                final index = entry.key;
                final question = entry.value;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: _QuestionCard(
                    index: index + 1,
                    question: question,
                    answer: _answers[question.id.toString()],
                    onChanged: (value) {
                      setState(() {
                        _answers[question.id.toString()] = value;
                      });
                    },
                  ),
                );
              }),

              const SizedBox(height: 20),
            ],
          ),
        ),

        // Submit bar
        Container(
          padding: EdgeInsets.fromLTRB(
            AppDimens.pagePadding,
            12,
            AppDimens.pagePadding,
            MediaQuery.of(context).padding.bottom + 12,
          ),
          decoration: BoxDecoration(
            color: AppColors.cardBg,
            boxShadow: [
              BoxShadow(
                color: AppColors.shadowMedium,
                blurRadius: 16,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: _submitting ? null : () => _submit(survey),
              child: _submitting
                  ? const SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(
                          strokeWidth: 2, color: Colors.white),
                    )
                  : const Text(
                      'Submit Survey',
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w700),
                    ),
            ),
          ),
        ),
      ],
    );
  }
}

// ─── Question Card ───────────────────────────────

class _QuestionCard extends StatelessWidget {
  final int index;
  final SurveyQuestion question;
  final dynamic answer;
  final ValueChanged<dynamic> onChanged;

  const _QuestionCard({
    required this.index,
    required this.question,
    required this.answer,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: _isAnswered
              ? AppColors.primary.withOpacity(0.3)
              : AppColors.border.withOpacity(0.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Question number + text
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: _isAnswered
                      ? AppColors.primary.withOpacity(0.1)
                      : AppColors.surfaceBg,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Q$index',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: _isAnswered
                        ? AppColors.primary
                        : AppColors.textHint,
                  ),
                ),
              ),
              if (question.isRequired)
                Padding(
                  padding: const EdgeInsets.only(left: 6, top: 2),
                  child: Text(
                    '*',
                    style: TextStyle(
                      color: AppColors.error,
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            question.question,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 14),

          // Answer input based on type
          if (question.type == 'single_choice')
            _buildSingleChoice()
          else if (question.type == 'multi_choice')
            _buildMultiChoice()
          else
            _buildTextInput(),
        ],
      ),
    );
  }

  bool get _isAnswered {
    if (answer == null) return false;
    if (answer is String) return answer.isNotEmpty;
    if (answer is List) return (answer as List).isNotEmpty;
    return false;
  }

  Widget _buildSingleChoice() {
    return Column(
      children: question.options.map((option) {
        final selected = answer == option;
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: GestureDetector(
            onTap: () => onChanged(option),
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                color: selected
                    ? AppColors.primary.withOpacity(0.08)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: selected
                      ? AppColors.primary
                      : AppColors.border.withOpacity(0.6),
                  width: selected ? 1.5 : 1,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color:
                            selected ? AppColors.primary : AppColors.textHint,
                        width: selected ? 5 : 1.5,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      option,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight:
                            selected ? FontWeight.w600 : FontWeight.w400,
                        color: selected
                            ? AppColors.primary
                            : AppColors.textPrimary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildMultiChoice() {
    final selectedList = List<String>.from(answer ?? []);
    return Column(
      children: question.options.map((option) {
        final selected = selectedList.contains(option);
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: GestureDetector(
            onTap: () {
              final updated = List<String>.from(selectedList);
              if (selected) {
                updated.remove(option);
              } else {
                updated.add(option);
              }
              onChanged(updated);
            },
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                color: selected
                    ? AppColors.primary.withOpacity(0.08)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: selected
                      ? AppColors.primary
                      : AppColors.border.withOpacity(0.6),
                  width: selected ? 1.5 : 1,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: selected
                          ? AppColors.primary
                          : Colors.transparent,
                      border: Border.all(
                        color: selected
                            ? AppColors.primary
                            : AppColors.textHint,
                        width: 1.5,
                      ),
                    ),
                    child: selected
                        ? const Icon(Icons.check_rounded,
                            size: 14, color: Colors.white)
                        : null,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      option,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight:
                            selected ? FontWeight.w600 : FontWeight.w400,
                        color: selected
                            ? AppColors.primary
                            : AppColors.textPrimary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildTextInput() {
    return TextField(
      onChanged: (val) => onChanged(val),
      maxLines: 3,
      decoration: InputDecoration(
        hintText: 'Type your answer...',
        hintStyle: const TextStyle(color: AppColors.textHint, fontSize: 14),
        filled: true,
        fillColor: AppColors.surfaceBg,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.border.withOpacity(0.5)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.border.withOpacity(0.5)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
        contentPadding: const EdgeInsets.all(14),
      ),
    );
  }
}
