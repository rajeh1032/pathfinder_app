import '../../domain/entities/course_skill.dart';
import 'course_model_parsing.dart';

class CourseSkillModel {
  const CourseSkillModel({
    required this.id,
    required this.name,
    this.category,
    this.level,
    this.confidence,
    this.source,
  });

  factory CourseSkillModel.fromJson(Map<String, dynamic> json) =>
      CourseSkillModel(
        id: requiredString(json, 'id'),
        name: requiredString(json, 'name'),
        category: nullableString(json['category']),
        level: nullableString(json['level']),
        confidence: nullableDouble(json['confidence']),
        source: nullableString(json['source']),
      );

  final String id;
  final String name;
  final String? category;
  final String? level;
  final double? confidence;
  final String? source;

  CourseSkill toEntity() => CourseSkill(
        id: id,
        name: name,
        category: category,
        level: level,
        confidence: confidence,
        source: source,
      );
}
