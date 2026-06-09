import 'package:flutter/material.dart';

import '../../features/interview/presentation/screens/active_interview_screen.dart';
import '../../features/interview/presentation/screens/interview_history_screen.dart';
import '../../features/interview/presentation/screens/interview_result_screen.dart';
import '../../features/interview/presentation/screens/interview_start_screen.dart';
import '../../features/root/presentation/screens/root_screen.dart';
import '../widgets/placeholder_screen.dart';
import 'app_routes.dart';

class AppRouter {
  const AppRouter._();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute<dynamic>(
      settings: settings,
      builder: (_) => _screenFor(settings.name),
    );
  }

  static Widget _screenFor(String? routeName) {
    return switch (routeName) {
      AppRoutes.root => const RootScreen(),
      AppRoutes.login => const PlaceholderScreen(titleKey: 'routes.login'),
      AppRoutes.splash => const PlaceholderScreen(titleKey: 'routes.splash'),
      AppRoutes.onboarding =>
        const PlaceholderScreen(titleKey: 'routes.onboarding'),
      AppRoutes.register => const PlaceholderScreen(titleKey: 'routes.register'),
      AppRoutes.forgotPassword =>
        const PlaceholderScreen(titleKey: 'routes.forgotPassword'),
      AppRoutes.verifyEmail =>
        const PlaceholderScreen(titleKey: 'routes.verifyEmail'),
      AppRoutes.home => const PlaceholderScreen(titleKey: 'routes.home'),
      AppRoutes.search => const PlaceholderScreen(titleKey: 'routes.search'),
      AppRoutes.profile => const PlaceholderScreen(titleKey: 'routes.profile'),
      AppRoutes.settings => const PlaceholderScreen(titleKey: 'routes.settings'),
      AppRoutes.notifications =>
        const PlaceholderScreen(titleKey: 'routes.notifications'),
      AppRoutes.cvUpload => const PlaceholderScreen(titleKey: 'routes.cvUpload'),
      AppRoutes.cvAnalysisResult =>
        const PlaceholderScreen(titleKey: 'routes.cvAnalysisResult'),
      AppRoutes.roadmapDetails =>
        const PlaceholderScreen(titleKey: 'routes.roadmapDetails'),
      AppRoutes.courseDetails =>
        const PlaceholderScreen(titleKey: 'routes.courseDetails'),
      AppRoutes.jobs => const PlaceholderScreen(titleKey: 'routes.jobs'),
      AppRoutes.jobDetails =>
        const PlaceholderScreen(titleKey: 'routes.jobDetails'),
      AppRoutes.coverLetterGenerator =>
        const PlaceholderScreen(titleKey: 'routes.coverLetterGenerator'),
      AppRoutes.coverLetterResult =>
        const PlaceholderScreen(titleKey: 'routes.coverLetterResult'),
      AppRoutes.aiChat => const PlaceholderScreen(titleKey: 'routes.aiChat'),
      AppRoutes.interviewStart => const InterviewStartScreen(),
      AppRoutes.activeInterview => const ActiveInterviewScreen(),
      AppRoutes.interviewHistory => const InterviewHistoryScreen(),
      AppRoutes.interviewResult => const InterviewResultScreen(),
      _ => const PlaceholderScreen(titleKey: 'common.error'),
    };
  }
}
