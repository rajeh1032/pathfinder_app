import 'package:flutter_test/flutter_test.dart';
import 'package:pathfinder_app/core/network/api_endpoints.dart';

void main() {
  group('ApiEndpoints', () {
    test('builds reusable resource endpoints from IDs', () {
      expect(ApiEndpoints.cvAnalysisDetails('12'), '/v1/cvs/12');
      expect(ApiEndpoints.cvHistory, '/v1/cvs/me/history');
      expect(ApiEndpoints.cvFileUrl('12'), '/v1/cvs/me/12/file-url');
      expect(ApiEndpoints.myRoadmap, '/v1/roadmaps/me');
      expect(ApiEndpoints.generateRoadmap, '/v1/roadmaps/generate');
      expect(ApiEndpoints.roadmapDetails('12'), '/v1/roadmaps/12');
      expect(
        ApiEndpoints.roadmapStepProgress('12', '34'),
        '/v1/roadmaps/12/steps/34/progress',
      );
      expect(ApiEndpoints.courses, '/v1/courses');
      expect(ApiEndpoints.recommendedCourses, '/v1/courses/recommended');
      expect(ApiEndpoints.savedCourses, '/v1/courses/saved');
      expect(ApiEndpoints.courseEnrollments, '/v1/courses/enrollments');
      expect(ApiEndpoints.courseDetails('12'), '/v1/courses/12');
      expect(ApiEndpoints.courseSave('12'), '/v1/courses/12/save');
      expect(ApiEndpoints.courseEnroll('12'), '/v1/courses/12/enroll');
      expect(
        ApiEndpoints.courseEnrollment('12'),
        '/v1/courses/12/enrollment',
      );
      expect(ApiEndpoints.jobDetails('12'), '/v1/jobs/12');
      expect(
        ApiEndpoints.chatMessages('12'),
        '/v1/chat/12/messages',
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
      expect(ApiEndpoints.jobDetails('job/12'), '/v1/jobs/job%2F12');
      expect(
        ApiEndpoints.cvFileUrl('cv/12'),
        '/v1/cvs/me/cv%2F12/file-url',
      );
      expect(
        ApiEndpoints.courseDetails('course/12'),
        '/v1/courses/course%2F12',
      );
      expect(
        ApiEndpoints.roadmapStepProgress('road/map', 'step one'),
        '/v1/roadmaps/road%2Fmap/steps/step%20one/progress',
      );
      expect(ApiEndpoints.chatMessages('session 1'),
          '/v1/chat/session%201/messages');
    });
  });
}
