/// Address model matching the API response
class AddressModel {
  final int id;
  final String? label;
  final String address;
  final String? city;
  final String? phone;
  final double? latitude;
  final double? longitude;
  final bool isDefault;

  const AddressModel({
    required this.id,
    this.label,
    required this.address,
    this.city,
    this.phone,
    this.latitude,
    this.longitude,
    this.isDefault = false,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json['id'] as int,
      label: json['label'] as String?,
      address: json['address'] as String,
      city: json['city'] as String?,
      phone: json['phone'] as String?,
      latitude: json['latitude'] != null
          ? double.tryParse(json['latitude'].toString())
          : null,
      longitude: json['longitude'] != null
          ? double.tryParse(json['longitude'].toString())
          : null,
      isDefault: json['is_default'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (label != null) 'label': label,
      'address': address,
      if (city != null) 'city': city,
      if (phone != null) 'phone': phone,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
    };
  }

  /// Display name: label if available, otherwise truncated address
  String get displayName => label ?? address.split(',').first;
}
