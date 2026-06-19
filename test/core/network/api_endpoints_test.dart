import 'package:flutter_test/flutter_test.dart';
import 'package:pathfinder_app/core/network/api_endpoints.dart';

void main() {
  group('ApiEndpoints', () {
    test('builds reusable resource endpoints from IDs', () {
      expect(ApiEndpoints.cvAnalysisDetails('12'), '/cv/analyses/12');
      expect(ApiEndpoints.roadmapDetails('12'), '/roadmaps/12');
      expect(ApiEndpoints.roadmapSteps('12'), '/roadmaps/12/steps');
      expect(ApiEndpoints.courseDetails('12'), '/courses/12');
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
      expect(ApiEndpoints.chatMessages('session 1'),
          '/chat/sessions/session%201/messages');
    });
  });
}
