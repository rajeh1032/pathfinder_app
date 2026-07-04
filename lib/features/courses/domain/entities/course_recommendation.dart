import 'package:equatable/equatable.dart';

import 'course.dart';

enum RecommendationReasonCode {
  coversMissingSkill,
  supportsRoadmapSkill,
  matchesTargetCareer,
  levelSuitable,
  freeCourse,
}

class RecommendationReason extends Equatable {
  const RecommendationReason({required this.code, required this.params});

  final RecommendationReasonCode code;
  final Map<String, String> params;

  @override
  List<Object?> get props => [code, params];
}

class CourseRecommendation extends Equatable {
  const CourseRecommendation({
    required this.course,
    required this.matchedSkills,
    required this.missingSkillsCovered,
    required this.coveragePercentage,
    required this.score,
    required this.scoreBreakdown,
    required this.matchReasons,
  });

  final Course course;
  final List<String> matchedSkills;
  final List<String> missingSkillsCovered;
  final int coveragePercentage;
  final double score;
  final Map<String, double> scoreBreakdown;
  final List<RecommendationReason> matchReasons;

  CourseRecommendation copyWith({Course? course}) => CourseRecommendation(
        course: course ?? this.course,
        matchedSkills: matchedSkills,
        missingSkillsCovered: missingSkillsCovered,
        coveragePercentage: coveragePercentage,
        score: score,
        scoreBreakdown: scoreBreakdown,
        matchReasons: matchReasons,
      );

  @override
  List<Object?> get props => [
        course,
        matchedSkills,
        missingSkillsCovered,
        coveragePercentage,
        score,
        scoreBreakdown,
        matchReasons,
      ];
}
