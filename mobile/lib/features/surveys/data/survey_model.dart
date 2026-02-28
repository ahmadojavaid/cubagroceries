/// Survey summary — returned from GET /surveys (for home card)
class SurveySummary {
  final int id;
  final String title;
  final String? description;
  final int questionsCount;
  final String? endsAt;

  const SurveySummary({
    required this.id,
    required this.title,
    this.description,
    required this.questionsCount,
    this.endsAt,
  });

  factory SurveySummary.fromJson(Map<String, dynamic> json) {
    return SurveySummary(
      id: json['id'] as int,
      title: json['title'] ?? '',
      description: json['description'] as String?,
      questionsCount: json['questions_count'] as int? ?? 0,
      endsAt: json['ends_at'] as String?,
    );
  }
}

/// Full survey detail — returned from GET /surveys/{id}
class SurveyDetail {
  final int id;
  final String title;
  final String? description;
  final List<SurveyQuestion> questions;

  const SurveyDetail({
    required this.id,
    required this.title,
    this.description,
    required this.questions,
  });

  factory SurveyDetail.fromJson(Map<String, dynamic> json) {
    return SurveyDetail(
      id: json['id'] as int,
      title: json['title'] ?? '',
      description: json['description'] as String?,
      questions: (json['questions'] as List)
          .map((q) => SurveyQuestion.fromJson(Map<String, dynamic>.from(q)))
          .toList(),
    );
  }
}

/// Individual survey question
class SurveyQuestion {
  final int id;
  final String question;
  final String type; // single_choice, multi_choice, text
  final List<String> options;
  final bool isRequired;

  const SurveyQuestion({
    required this.id,
    required this.question,
    required this.type,
    required this.options,
    required this.isRequired,
  });

  factory SurveyQuestion.fromJson(Map<String, dynamic> json) {
    return SurveyQuestion(
      id: json['id'] as int,
      question: json['question'] ?? '',
      type: json['type'] ?? 'single_choice',
      options: List<String>.from(json['options'] ?? []),
      isRequired: json['is_required'] as bool? ?? true,
    );
  }
}
