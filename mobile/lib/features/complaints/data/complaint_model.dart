/// Complaint model for list view (GET /api/v1/complaints)
class ComplaintModel {
  final int id;
  final String subject;
  final String message;
  final String status;
  final int? orderId;
  final String? orderNumber;
  final String? orderStatus;
  final DateTime createdAt;

  const ComplaintModel({
    required this.id,
    required this.subject,
    required this.message,
    required this.status,
    this.orderId,
    this.orderNumber,
    this.orderStatus,
    required this.createdAt,
  });

  factory ComplaintModel.fromJson(Map<String, dynamic> json) {
    final order = json['order'] != null
        ? Map<String, dynamic>.from(json['order'])
        : null;

    return ComplaintModel(
      id: json['id'],
      subject: json['subject'] ?? '',
      message: json['message'] ?? '',
      status: json['status'] ?? 'pending',
      orderId: json['order_id'] as int?,
      orderNumber: order?['order_id'] as String?,
      orderStatus: order?['status'] as String?,
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  String get displayStatus {
    switch (status) {
      case 'in_progress':
        return 'In Progress';
      default:
        return status[0].toUpperCase() + status.substring(1);
    }
  }

  bool get isPending => status == 'pending';
  bool get isInProgress => status == 'in_progress';
  bool get isResolved => status == 'resolved';
  bool get isClosed => status == 'closed';
}
