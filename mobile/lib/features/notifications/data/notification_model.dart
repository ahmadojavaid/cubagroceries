/// Notification model matching Laravel database notification format.
class NotificationModel {
  final String id;
  final String type;
  final Map<String, dynamic> data;
  final DateTime? readAt;
  final DateTime createdAt;

  const NotificationModel({
    required this.id,
    required this.type,
    required this.data,
    this.readAt,
    required this.createdAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] as String,
      type: json['type'] as String? ?? '',
      data: json['data'] != null
          ? Map<String, dynamic>.from(json['data'])
          : {},
      readAt: json['read_at'] != null
          ? DateTime.parse(json['read_at'])
          : null,
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  /// Whether this notification has been read.
  bool get isRead => readAt != null;

  /// Title extracted from the notification data payload.
  String get title => data['title'] as String? ?? 'Notification';

  /// Body/message extracted from the notification data payload.
  String get message => data['message'] as String? ?? '';

  /// Order number if this is an order-related notification.
  String? get orderNumber => data['order_number'] as String?;

  /// New status if this is an order status change notification.
  String? get newStatus => data['new_status'] as String?;

  /// Whether this is an order status change notification.
  bool get isOrderStatusChange =>
      type.contains('OrderStatusChanged') || data.containsKey('order_number');

  /// Return a copy with readAt set to now (for optimistic UI updates).
  NotificationModel markAsRead() {
    return NotificationModel(
      id: id,
      type: type,
      data: data,
      readAt: DateTime.now(),
      createdAt: createdAt,
    );
  }
}
