import '../../domain/entities/course_recommendation.dart';
import 'course_model.dart';
import 'course_model_parsing.dart';

class RecommendationReasonModel {
  const RecommendationReasonModel({required this.code, required this.params});

  factory RecommendationReasonModel.fromJson(Map<String, dynamic> json) {
    final paramsJson = requiredMap(json['params'], 'params');
    final params = <String, String>{};
    for (final entry in paramsJson.entries) {
      if (entry.value is! String) throw const FormatException('Invalid params');
      params[entry.key] = entry.value as String;
    }
    return RecommendationReasonModel(
      code: _code(requiredString(json, 'code')),
      params: params,
    );
  }

  final RecommendationReasonCode code;
  final Map<String, String> params;

  RecommendationReason toEntity() => RecommendationReason(
        code: code,
        params: Map.unmodifiable(params),
      );

  static RecommendationReasonCode _code(String value) => switch (value) {
        'covers_missing_skill' => RecommendationReasonCode.coversMissingSkill,
        'supports_roadmap_skill' =>
          RecommendationReasonCode.supportsRoadmapSkill,
        'matches_target_career' => RecommendationReasonCode.matchesTargetCareer,
        'level_suitable' => RecommendationReasonCode.levelSuitable,
        'free_course' => RecommendationReasonCode.freeCourse,
        _ => throw const FormatException('Unknown recommendation reason'),
      };
}

class CourseRecommendationModel {
  const CourseRecommendationModel({
    required this.course,
    required this.matchedSkills,
    required this.missingSkillsCovered,
    required this.coveragePercentage,
    required this.score,
    required this.scoreBreakdown,
    required this.matchReasons,
  });

  factory CourseRecommendationModel.fromJson(Map<String, dynamic> json) {
    final breakdownJson = requiredMap(json['scoreBreakdown'], 'scoreBreakdown');
    final breakdown = <String, double>{};
    for (final entry in breakdownJson.entries) {
      final value = nullableDouble(entry.value);
      if (value == null) throw const FormatException('Invalid score breakdown');
      breakdown[entry.key] = value;
    }
    final coverage = requiredInt(json, 'coveragePercentage', min: 0);
    if (coverage > 100) throw const FormatException('Invalid coverage');
    return CourseRecommendationModel(
      course: CourseModel.fromJson(json),
      matchedSkills: stringList(json, 'matchedSkills'),
      missingSkillsCovered: stringList(json, 'missingSkillsCovered'),
      coveragePercentage: coverage,
      score: nullableDouble(json['score']) ??
          (throw const FormatException('Invalid score')),
      scoreBreakdown: breakdown,
      matchReasons: requiredList(json, 'matchReasons')
          .map((item) => RecommendationReasonModel.fromJson(
                requiredMap(item, 'reason'),
              ))
          .toList(growable: false),
    );
  }

  final CourseModel course;
  final List<String> matchedSkills;
  final List<String> missingSkillsCovered;
  final int coveragePercentage;
  final double score;
  final Map<String, double> scoreBreakdown;
  final List<RecommendationReasonModel> matchReasons;

  CourseRecommendation toEntity() => CourseRecommendation(
        course: course.toEntity(),
        matchedSkills: List.unmodifiable(matchedSkills),
        missingSkillsCovered: List.unmodifiable(missingSkillsCovered),
        coveragePercentage: coveragePercentage,
        score: score,
        scoreBreakdown: Map.unmodifiable(scoreBreakdown),
        matchReasons:
            List.unmodifiable(matchReasons.map((item) => item.toEntity())),
      );
}
