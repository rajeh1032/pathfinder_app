import 'package:equatable/equatable.dart';

class CourseSkill extends Equatable {
  const CourseSkill({
    required this.id,
    required this.name,
    this.category,
    this.level,
    this.confidence,
    this.source,
  });

  final String id;
  final String name;
  final String? category;
  final String? level;
  final double? confidence;
  final String? source;

  @override
  List<Object?> get props => [id, name, category, level, confidence, source];
}
