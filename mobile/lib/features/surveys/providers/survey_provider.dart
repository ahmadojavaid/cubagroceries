import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/api_provider.dart';
import '../data/survey_model.dart';

/// Pending surveys for home card
final pendingSurveysProvider =
    FutureProvider<List<SurveySummary>>((ref) async {
  final api = ref.watch(apiClientProvider);
  try {
    final response = await api.get('/surveys');
    final data = response.data;
    if (data['success'] == true && data['data'] != null) {
      return (data['data'] as List)
          .map((s) => SurveySummary.fromJson(Map<String, dynamic>.from(s)))
          .toList();
    }
    return [];
  } catch (_) {
    return [];
  }
});

/// Full survey detail
final surveyDetailProvider =
    FutureProvider.family<SurveyDetail?, int>((ref, surveyId) async {
  final api = ref.watch(apiClientProvider);
  try {
    final response = await api.get('/surveys/$surveyId');
    final data = response.data;
    if (data['success'] == true && data['data'] != null) {
      return SurveyDetail.fromJson(Map<String, dynamic>.from(data['data']));
    }
    return null;
  } catch (_) {
    return null;
  }
});
