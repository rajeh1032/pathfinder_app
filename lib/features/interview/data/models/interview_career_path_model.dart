import '../../domain/entities/interview_career_path.dart';

class InterviewCareerPathModel {
  const InterviewCareerPathModel({
    required this.id,
    required this.name,
    this.description,
    this.iconName,
  });

  factory InterviewCareerPathModel.fromJson(Map<String, dynamic> json) {
    return InterviewCareerPathModel(
      id: _readString(json, ['id', 'career_path_id', 'careerPathId']),
      name: _readString(
        json,
        ['name', 'title', 'career_path_name', 'careerPathName', 'label'],
      ),
      description: _readNullableString(
        json,
        ['description', 'summary', 'body', 'career_path_description'],
      ),
      iconName: _readNullableString(json, ['icon', 'icon_name', 'iconName']),
    );
  }

  final String id;
  final String name;
  final String? description;
  final String? iconName;

  InterviewCareerPath toEntity() {
    return InterviewCareerPath(
      id: id,
      name: name,
      description: description,
      iconName: iconName,
    );
  }

  static String _readString(Map<String, dynamic> json, List<String> keys) {
    for (final key in keys) {
      final value = json[key];
      if (value != null) {
        final text = value.toString().trim();
        if (text.isNotEmpty) return text;
      }
    }
    return '';
  }

  static String? _readNullableString(
    Map<String, dynamic> json,
    List<String> keys,
  ) {
    for (final key in keys) {
      final value = json[key];
      if (value != null) {
        final text = value.toString().trim();
        if (text.isNotEmpty) return text;
      }
    }
    return null;
  }
}
