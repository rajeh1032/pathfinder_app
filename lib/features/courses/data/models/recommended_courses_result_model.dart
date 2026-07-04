import '../../domain/entities/courses_page.dart';
import 'course_model_parsing.dart';
import 'course_recommendation_model.dart';

class RecommendedCoursesResultModel {
  const RecommendedCoursesResultModel({
    required this.hasRecommendations,
    required this.courses,
    required this.missingSkills,
    this.requiredAction,
    this.targetCareer,
  });

  factory RecommendedCoursesResultModel.fromJson(Map<String, dynamic> json) {
    final action = nullableString(json['requiredAction']);
    if (action != null && action != 'upload_cv') {
      throw const FormatException('Unknown required action');
    }
    final missing = json.containsKey('missingSkills')
        ? stringList(json, 'missingSkills')
        : const <String>[];
    return RecommendedCoursesResultModel(
      hasRecommendations: requiredBool(json, 'hasRecommendations'),
      requiredAction: action,
      targetCareer: nullableString(json['targetCareer']),
      missingSkills: missing,
      courses: requiredList(json, 'courses')
          .map((item) => CourseRecommendationModel.fromJson(
                requiredMap(item, 'recommended course'),
              ))
          .toList(growable: false),
    );
  }

  final bool hasRecommendations;
  final String? requiredAction;
  final String? targetCareer;
  final List<String> missingSkills;
  final List<CourseRecommendationModel> courses;

  RecommendedCoursesResult toEntity() => RecommendedCoursesResult(
        hasRecommendations: hasRecommendations,
        requiredAction: requiredAction,
        targetCareer: targetCareer,
        missingSkills: List.unmodifiable(missingSkills),
        courses: List.unmodifiable(courses.map((item) => item.toEntity())),
      );
}
