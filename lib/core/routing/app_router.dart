import 'package:flutter/material.dart';
import 'package:pathfinder_app/features/auth/presentation/screens/change_password_screen.dart';
import 'package:pathfinder_app/features/auth/presentation/screens/forgot_password_screen.dart';
import 'package:pathfinder_app/features/auth/presentation/screens/login_screen.dart';
import 'package:pathfinder_app/features/auth/presentation/screens/register_screen_test.dart';
import 'package:pathfinder_app/features/auth/presentation/screens/setup_profile_screen.dart';
import 'package:pathfinder_app/features/auth/presentation/screens/verfiy_email_sreen.dart';
import 'package:pathfinder_app/features/cv_analysis/presentation/screens/cv_analysis.dart';

import '../../features/cover_letters/presentation/screens/cover_letter_generator_screen.dart';
import '../../features/jobs/presentation/screens/job_details_screen.dart';
import '../../features/ai_chat/presentation/screens/chat_with_ai.dart';
import '../../features/interview/presentation/screens/active_interview_screen.dart';
import '../../features/interview/presentation/screens/interview_result_screen.dart';
import '../../features/interview/presentation/screens/interview_start_screen.dart';
import '../../features/courses/presentation/screens/course_details_screen.dart';
import '../../features/courses/presentation/screens/courses_screen.dart';
import '../../features/notifications/presentation/screens/notifications_screen.dart';
import '../../features/profile/presentation/screens/edit_profile_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';
import '../../features/profile/presentation/screens/reset_password_screen.dart';
import '../../features/roadmaps/presentation/screens/roadmap_details_screen.dart';
import '../../features/roadmaps/presentation/screens/roadmaps_screen.dart';
import '../../features/root/presentation/screens/root_screen.dart';
import '../../features/search/presentation/screens/search_screen.dart';
import '../../features/splash/presentation/screens/splash_screen.dart';
import '../../features/onboarding/presentation/screens/onboarding_screen.dart';
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
      AppRoutes.splash => const SplashScreen(),
      AppRoutes.onboarding => const OnboardingScreen(),

      // Auth
      AppRoutes.login => const LoginScreen(),
      AppRoutes.register => const RegisterScreenTest(),
      AppRoutes.forgotPassword => const ForgotPasswordScreen(),
      AppRoutes.verifyEmail => const VerifyEmailScreen(),
      AppRoutes.changePassword => const ChangePasswordScreen(),
      AppRoutes.setupProfile => const SetupProfileScreen(),

      // Home / Search
      AppRoutes.home => const PlaceholderScreen(titleKey: 'routes.home'),
      AppRoutes.search => const SearchScreen(),

      // Profile
      AppRoutes.profile => const ProfileScreen(),
      AppRoutes.editProfile => const EditProfileScreen(),
      AppRoutes.profileResetPassword => const ResetPasswordScreen(),

      // Settings
      AppRoutes.settings => const SettingsScreen(),
      AppRoutes.themeSettings => const ThemeSettingsScreen(),
      AppRoutes.languageSettings => const LanguageSettingsScreen(),
      AppRoutes.mentorToneSettings => const MentorToneSettingsScreen(),
      AppRoutes.careerGoalSettings => const CareerGoalSettingsScreen(),
      AppRoutes.helpCenter => const HelpCenterScreen(),
      AppRoutes.privacyPolicy => const PrivacyPolicyScreen(),
      AppRoutes.termsOfService => const TermsOfServiceScreen(),

      // Notifications
      AppRoutes.notifications => const NotificationsScreen(),

      // Courses & Roadmaps
      AppRoutes.courses => const CoursesScreen(),
      AppRoutes.roadmaps => const RoadmapsScreen(),
      AppRoutes.roadmapDetails => RoadmapDetailsScreen(roadmapId: routeId),
      AppRoutes.courseDetails => CourseDetailsScreen(courseId: routeId),

      // CV
      AppRoutes.cvUpload =>
        const PlaceholderScreen(titleKey: 'routes.cvUpload'),
      AppRoutes.cvAnalysisResult => const CvAnalysisResult(),

      // Jobs
      AppRoutes.jobs => const PlaceholderScreen(titleKey: 'routes.jobs'),
      AppRoutes.jobDetails => const JobDetailsScreen(),

      // Cover Letter
      AppRoutes.coverLetterGenerator => const CoverLetterGeneratorScreen(),
      AppRoutes.coverLetterResult =>
        const PlaceholderScreen(titleKey: 'routes.coverLetterResult'),

      // AI Chat
      AppRoutes.aiChat => const ChatWithAiScreen(),

      // Interview
      AppRoutes.interviewStart => const InterviewStartScreen(),
      AppRoutes.activeInterview => const ActiveInterviewScreen(),
      AppRoutes.interviewResult => const InterviewResultScreen(),
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
