import 'package:flutter_test/flutter_test.dart';
import 'package:pathfinder_app/features/courses/data/models/course_model.dart';
import 'package:pathfinder_app/features/courses/data/models/course_mutation_models.dart';
import 'package:pathfinder_app/features/courses/data/models/courses_page_model.dart';
import 'package:pathfinder_app/features/courses/data/models/recommended_courses_result_model.dart';
import 'package:pathfinder_app/features/courses/domain/entities/course_recommendation.dart';

import '../../course_fixtures.dart';

void main() {
  group('Course models', () {
    test('parses a full course and maps runtime fields', () {
      final course = CourseModel.fromJson(courseJson).toEntity();
      expect(course.title, 'React Fundamentals');
      expect(course.rating, 4.7);
      expect(course.skills.single.name, 'React');
      expect(course.createdAt, DateTime.utc(2026, 6, 20, 10));
    });

    test('keeps nullable course values null', () {
      final json = Map<String, dynamic>.from(courseJson)
        ..addAll({
          'description': null,
          'url': null,
          'level': null,
          'duration': null,
          'price': null,
          'currency': null,
          'rating': null,
        });
      final course = CourseModel.fromJson(json).toEntity();
      expect(course.description, isNull);
      expect(course.price, isNull);
      expect(course.rating, isNull);
    });

    test('rejects malformed required fields', () {
      final json = Map<String, dynamic>.from(courseJson)..remove('title');
      expect(() => CourseModel.fromJson(json), throwsFormatException);
    });

    test('parses pagination from list envelope parts', () {
      final page = CoursesPageModel.fromParts(
        data: {
          'courses': [courseJson]
        },
        meta: {
          'pagination': {
            'page': 1,
            'limit': 20,
            'totalItems': 1,
            'totalPages': 1,
            'hasNextPage': false,
            'hasPreviousPage': false,
            'nextPage': null,
            'previousPage': null,
          }
        },
      ).toEntity();
      expect(page.courses, hasLength(1));
      expect(page.pagination.totalItems, 1);
    });

    test('parses recommendation reasons and upload action', () {
      final recommended = Map<String, dynamic>.from(courseJson)
        ..addAll({
          'matchedSkills': ['React'],
          'missingSkillsCovered': ['React'],
          'coveragePercentage': 100,
          'score': 94,
          'scoreBreakdown': {'skillGapCoverage': 55},
          'matchReasons': [
            {
              'code': 'covers_missing_skill',
              'params': {'skill': 'React'}
            }
          ],
        });
      final result = RecommendedCoursesResultModel.fromJson({
        'hasRecommendations': true,
        'targetCareer': 'Frontend Developer',
        'missingSkills': ['React'],
        'courses': [recommended],
      }).toEntity();
      expect(result.courses.single.score, 94);
      expect(result.courses.single.matchReasons.single.code,
          RecommendationReasonCode.coversMissingSkill);

      final action = RecommendedCoursesResultModel.fromJson({
        'hasRecommendations': false,
        'requiredAction': 'upload_cv',
        'courses': <dynamic>[],
      }).toEntity();
      expect(action.requiredAction, 'upload_cv');
    });

    test('parses saved and enrollment mutation results', () {
      final saved = SavedCourseResultModel.fromJson({
        'courseId': courseJson['id'],
        'isSaved': true,
        'alreadySaved': false,
      }).toEntity();
      final enrolled = EnrollmentMutationResultModel.fromJson({
        'courseId': courseJson['id'],
        'alreadyEnrolled': true,
        'enrollment': enrollmentJson,
      }).toEntity();
      expect(saved.isSaved, isTrue);
      expect(enrolled.enrollment.progress, 40);
      expect(enrolled.alreadyEnrolled, isTrue);
    });
  });
}
