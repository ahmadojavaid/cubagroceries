/// User profile model matching the API response
class UserModel {
  final int id;
  final String identity;
  final String email;
  final String firstname;
  final String lastname;
  final String? dateOfBirth;
  final String walletAmount;

  const UserModel({
    required this.id,
    required this.identity,
    required this.email,
    required this.firstname,
    required this.lastname,
    this.dateOfBirth,
    this.walletAmount = '0.00',
  });

  String get fullName => '$firstname $lastname';

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int,
      identity: json['identity'] as String,
      email: json['email'] as String,
      firstname: json['firstname'] as String,
      lastname: json['lastname'] as String,
      dateOfBirth: json['date_of_birth'] as String?,
      walletAmount: (json['wallet_amount'] ?? '0.00').toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'date_of_birth': dateOfBirth,
    };
  }

  UserModel copyWith({
    String? identity,
    String? email,
    String? firstname,
    String? lastname,
    String? dateOfBirth,
    String? walletAmount,
  }) {
    return UserModel(
      id: id,
      identity: identity ?? this.identity,
      email: email ?? this.email,
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      walletAmount: walletAmount ?? this.walletAmount,
    );
  }
}
