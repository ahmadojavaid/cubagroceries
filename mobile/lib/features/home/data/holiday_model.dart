class HolidayModel {
  final bool isOffline;
  final String title;
  final String message;
  final String? image;
  final DateTime? holidayEnd;
  final bool allowAdvanceOrders;

  const HolidayModel({
    required this.isOffline,
    required this.title,
    required this.message,
    this.image,
    this.holidayEnd,
    required this.allowAdvanceOrders,
  });

  factory HolidayModel.fromJson(Map<String, dynamic> json) {
    return HolidayModel(
      isOffline: json['is_offline'] as bool? ?? false,
      title: json['title'] as String? ?? 'We\'re currently closed',
      message: json['message'] as String? ?? 'We\'ll be back soon!',
      image: json['image'] as String?,
      holidayEnd: json['holiday_end'] != null
          ? DateTime.tryParse(json['holiday_end'] as String)
          : null,
      allowAdvanceOrders: json['allow_advance_orders'] as bool? ?? true,
    );
  }
}
