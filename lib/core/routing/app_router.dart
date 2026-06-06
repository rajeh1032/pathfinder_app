import 'package:flutter/material.dart';

import '../../features/courses/presentation/screens/course_details_screen.dart';
import '../../features/courses/presentation/screens/courses_screen.dart';
import '../../features/notifications/presentation/screens/notifications_screen.dart';
import '../../features/profile/presentation/screens/edit_profile_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';
import '../../features/profile/presentation/screens/reset_password_screen.dart';
import '../../features/roadmaps/presentation/screens/roadmap_details_screen.dart';
import '../../features/roadmaps/presentation/screens/roadmaps_screen.dart';
import '../../features/root/presentation/screens/root_screen.dart';
import '../../features/settings/presentation/screens/language_settings_screen.dart';
import '../../features/settings/presentation/screens/ai_personalization_settings_screens.dart';
import '../../features/settings/presentation/screens/settings_screen.dart';
import '../../features/settings/presentation/screens/support_legal_screens.dart';
import '../../features/settings/presentation/screens/theme_settings_screen.dart';
import '../widgets/placeholder_screen.dart';
import 'app_routes.dart';
import 'route_arguments.dart';

class AppRouter {
  const AppRouter._();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute<dynamic>(
      settings: settings,
      builder: (_) => _screenFor(settings),
    );
  }

  static Widget _screenFor(RouteSettings settings) {
    final routeId = _routeIdFrom(settings.arguments);

    return switch (settings.name) {
      AppRoutes.root => const RootScreen(),
      AppRoutes.login => const PlaceholderScreen(titleKey: 'routes.login'),
      AppRoutes.splash => const PlaceholderScreen(titleKey: 'routes.splash'),
      AppRoutes.onboarding =>
        const PlaceholderScreen(titleKey: 'routes.onboarding'),
      AppRoutes.register =>
        const PlaceholderScreen(titleKey: 'routes.register'),
      AppRoutes.forgotPassword =>
        const PlaceholderScreen(titleKey: 'routes.forgotPassword'),
      AppRoutes.verifyEmail =>
        const PlaceholderScreen(titleKey: 'routes.verifyEmail'),
      AppRoutes.home => const PlaceholderScreen(titleKey: 'routes.home'),
      AppRoutes.courses => const CoursesScreen(),
      AppRoutes.roadmaps => const RoadmapsScreen(),
      AppRoutes.search => const PlaceholderScreen(titleKey: 'routes.search'),
      AppRoutes.profile => const ProfileScreen(),
      AppRoutes.editProfile => const EditProfileScreen(),
      AppRoutes.profileResetPassword => const ResetPasswordScreen(),
      AppRoutes.settings => const SettingsScreen(),
      AppRoutes.themeSettings => const ThemeSettingsScreen(),
      AppRoutes.languageSettings => const LanguageSettingsScreen(),
      AppRoutes.mentorToneSettings => const MentorToneSettingsScreen(),
      AppRoutes.careerGoalSettings => const CareerGoalSettingsScreen(),
      AppRoutes.helpCenter => const HelpCenterScreen(),
      AppRoutes.privacyPolicy => const PrivacyPolicyScreen(),
      AppRoutes.termsOfService => const TermsOfServiceScreen(),
      AppRoutes.notifications => const NotificationsScreen(),
      AppRoutes.cvUpload =>
        const PlaceholderScreen(titleKey: 'routes.cvUpload'),
      AppRoutes.cvAnalysisResult =>
        const PlaceholderScreen(titleKey: 'routes.cvAnalysisResult'),
      AppRoutes.roadmapDetails => RoadmapDetailsScreen(roadmapId: routeId),
      AppRoutes.courseDetails => CourseDetailsScreen(courseId: routeId),
      AppRoutes.jobs => const PlaceholderScreen(titleKey: 'routes.jobs'),
      AppRoutes.jobDetails =>
        const PlaceholderScreen(titleKey: 'routes.jobDetails'),
      AppRoutes.coverLetterGenerator =>
        const PlaceholderScreen(titleKey: 'routes.coverLetterGenerator'),
      AppRoutes.coverLetterResult =>
        const PlaceholderScreen(titleKey: 'routes.coverLetterResult'),
      AppRoutes.aiChat => const PlaceholderScreen(titleKey: 'routes.aiChat'),
      AppRoutes.interviewStart =>
        const PlaceholderScreen(titleKey: 'routes.interviewStart'),
      AppRoutes.activeInterview =>
        const PlaceholderScreen(titleKey: 'routes.activeInterview'),
      AppRoutes.interviewResult =>
        const PlaceholderScreen(titleKey: 'routes.interviewResult'),
      _ => const PlaceholderScreen(titleKey: 'common.error'),
    };
  }

  static String? _routeIdFrom(Object? arguments) {
    return switch (arguments) {
      final RouteArguments args => args.id,
      final String id => id,
      _ => null,
    };
  }
}
