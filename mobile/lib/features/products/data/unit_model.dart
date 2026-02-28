/// Unit model matching API response
class UnitModel {
  final int id;
  final String name;
  final String? abbreviation;

  const UnitModel({
    required this.id,
    required this.name,
    this.abbreviation,
  });

  factory UnitModel.fromJson(Map<String, dynamic> json) {
    return UnitModel(
      id: json['id'],
      name: json['name'] ?? '',
      abbreviation: json['abbreviation'],
    );
  }

  /// Display label: abbreviation if available, otherwise name
  String get label => abbreviation ?? name;
}
