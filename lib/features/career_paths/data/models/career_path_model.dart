import '../../domain/entities/career_path.dart';

class CareerPathModel {
  const CareerPathModel({
    required this.id,
    required this.title,
  });

  final String id;
  final String title;

  factory CareerPathModel.fromJson(Map<String, dynamic> json) {
    return CareerPathModel(
      id: _readString(json, ['id', '_id']) ?? '',
      title: _readString(json, ['title', 'name', 'careerPath']) ?? '',
    );
  }

  CareerPath toEntity() => CareerPath(id: id, title: title);

  static String? _readString(Map<String, dynamic> json, List<String> keys) {
    for (final key in keys) {
      final value = json[key];
      if (value is String && value.isNotEmpty) return value;
    }
    return null;
  }
}
