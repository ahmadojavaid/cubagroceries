class WalletTransactionModel {
  final int id;
  final String type; // 'credit' or 'debit'
  final double amount;
  final double balanceAfter;
  final String source; // admin_topup, admin_deduct, order_payment, order_refund
  final String? note;
  final DateTime createdAt;

  const WalletTransactionModel({
    required this.id,
    required this.type,
    required this.amount,
    required this.balanceAfter,
    required this.source,
    this.note,
    required this.createdAt,
  });

  bool get isCredit => type == 'credit';

  String get displayAmount =>
      '${isCredit ? '+' : '-'} Rs. ${amount.toStringAsFixed(0)}';

  String get displayBalance => 'Rs. ${balanceAfter.toStringAsFixed(0)}';

  String get sourceLabel => switch (source) {
        'admin_topup' => 'Wallet Top-up',
        'admin_deduct' => 'Wallet Deduction',
        'order_payment' => 'Order Payment',
        'order_refund' => 'Order Refund',
        _ => source.replaceAll('_', ' '),
      };

  factory WalletTransactionModel.fromJson(Map<String, dynamic> json) {
    return WalletTransactionModel(
      id: json['id'] as int,
      type: json['type'] as String,
      amount: double.parse(json['amount'].toString()),
      balanceAfter: double.parse(json['balance_after'].toString()),
      source: json['source'] as String,
      note: json['note'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }
}
