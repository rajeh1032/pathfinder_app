import '../../domain/entities/roadmap.dart';
import '../../domain/entities/roadmap_status.dart';

String requiredString(Map<String, dynamic> json, String key) {
  final value = json[key];
  if (value is String && value.trim().isNotEmpty) return value.trim();
  throw FormatException('Invalid or missing $key');
}

String? nullableString(Object? value) {
  if (value == null) return null;
  if (value is String) return value.trim().isEmpty ? null : value.trim();
  throw const FormatException('Expected a nullable string');
}

int requiredInt(Map<String, dynamic> json, String key, {int? min, int? max}) {
  final value = json[key];
  if (value is! num || value % 1 != 0) {
    throw FormatException('Invalid or missing $key');
  }
  final parsed = value.toInt();
  if ((min != null && parsed < min) || (max != null && parsed > max)) {
    throw FormatException('$key is outside the supported range');
  }
  return parsed;
}

Map<String, dynamic> requiredMap(Object? value, String name) {
  if (value is Map<String, dynamic>) return value;
  throw FormatException('Invalid or missing $name');
}

List<Map<String, dynamic>> mapList(Object? value, String name) {
  if (value == null) return const [];
  if (value is! List) throw FormatException('Invalid $name');
  return value.map((item) => requiredMap(item, name)).toList(growable: false);
}

RoadmapStepStatus stepStatusFromJson(Object? value) => switch (value) {
      'completed' => RoadmapStepStatus.completed,
      'in_progress' => RoadmapStepStatus.inProgress,
      'upcoming' => RoadmapStepStatus.upcoming,
      _ => RoadmapStepStatus.upcoming,
    };

RequiredRoadmapAction? requiredActionFromJson(Object? value) => switch (value) {
      null => null,
      'upload_cv' => RequiredRoadmapAction.uploadCv,
      'generate_roadmap' => RequiredRoadmapAction.generateRoadmap,
      _ => throw const FormatException('Unknown required roadmap action'),
    };
