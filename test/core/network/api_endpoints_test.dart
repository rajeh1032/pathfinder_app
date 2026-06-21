import 'package:flutter_test/flutter_test.dart';
import 'package:pathfinder_app/core/network/api_endpoints.dart';

void main() {
  group('ApiEndpoints', () {
    test('builds reusable resource endpoints from IDs', () {
      expect(ApiEndpoints.cvAnalysisDetails('12'), '/cv/analyses/12');
      expect(ApiEndpoints.myRoadmap, '/api/v1/roadmaps/me');
      expect(ApiEndpoints.generateRoadmap, '/api/v1/roadmaps/generate');
      expect(ApiEndpoints.roadmapDetails('12'), '/api/v1/roadmaps/12');
      expect(
        ApiEndpoints.roadmapStepProgress('12', '34'),
        '/api/v1/roadmaps/12/steps/34/progress',
      );
      expect(ApiEndpoints.courses, '/api/v1/courses');
      expect(ApiEndpoints.recommendedCourses, '/api/v1/courses/recommended');
      expect(ApiEndpoints.savedCourses, '/api/v1/courses/saved');
      expect(ApiEndpoints.courseEnrollments, '/api/v1/courses/enrollments');
      expect(ApiEndpoints.courseDetails('12'), '/api/v1/courses/12');
      expect(ApiEndpoints.courseSave('12'), '/api/v1/courses/12/save');
      expect(ApiEndpoints.courseEnroll('12'), '/api/v1/courses/12/enroll');
      expect(
        ApiEndpoints.courseEnrollment('12'),
        '/api/v1/courses/12/enrollment',
      );
      expect(ApiEndpoints.jobDetails('12'), '/jobs/12');
      expect(
        ApiEndpoints.chatMessages('12'),
        '/chat/sessions/12/messages',
      );
      expect(
        ApiEndpoints.submitInterviewAnswer('12'),
        '/interviews/12/answers',
      );
      expect(ApiEndpoints.interviewResult('12'), '/interviews/12/result');
      expect(
        ApiEndpoints.markNotificationAsRead('12'),
        '/notifications/12/read',
      );
    });

    test('encodes IDs as safe URL path segments', () {
      expect(ApiEndpoints.jobDetails('job/12'), '/jobs/job%2F12');
      expect(
        ApiEndpoints.courseDetails('course/12'),
        '/api/v1/courses/course%2F12',
      );
      expect(
        ApiEndpoints.roadmapStepProgress('road/map', 'step one'),
        '/api/v1/roadmaps/road%2Fmap/steps/step%20one/progress',
      );
      expect(ApiEndpoints.chatMessages('session 1'),
          '/chat/sessions/session%201/messages');
    });
  });
}
