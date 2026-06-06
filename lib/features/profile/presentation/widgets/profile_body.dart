import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/routing/app_routes.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/utils/custom_snackbar.dart';
import '../cubit/profile_cubit.dart';
import '../cubit/profile_state.dart';
import 'profile_achievements_card.dart';
import 'profile_education_card.dart';
import 'profile_experience_card.dart';
import 'profile_goal_card.dart';
import 'profile_header.dart';
import 'profile_info_card.dart';
import 'profile_saved_courses_card.dart';
import 'profile_saved_jobs_card.dart';
import 'profile_skills_card.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({required this.state, super.key});

  final ProfileSuccess state;

  @override
  Widget build(BuildContext context) {
    final profile = state.profile;

    return ListView(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.lg,
        AppSpacing.lg,
        AppSpacing.xxl,
      ),
      children: [
        ProfileHeader(
          profile: profile,
          onEditPhoto: () => _openEditProfile(context),
        ),
        const SizedBox(height: AppSpacing.lg),
        ProfileInfoCard(profile: profile),
        const SizedBox(height: AppSpacing.md),
        ProfileGoalCard(goal: profile.goal),
        const SizedBox(height: AppSpacing.md),
        ProfileExperienceCard(experiences: profile.experiences),
        const SizedBox(height: AppSpacing.md),
        ProfileSkillsCard(skillGroups: profile.skillGroups),
        const SizedBox(height: AppSpacing.md),
        ProfileAchievementsCard(achievements: profile.achievements),
        const SizedBox(height: AppSpacing.md),
        ProfileSavedCoursesCard(
          courses: profile.savedCourses,
          savedCourseIds: state.savedCourseIds,
          onToggleSaved: (id) => _toggleSavedCourse(context, id),
        ),
        const SizedBox(height: AppSpacing.md),
        ProfileSavedJobsCard(
          jobs: profile.savedJobs,
          savedJobIds: state.savedJobIds,
          onToggleSaved: (id) => _toggleSavedJob(context, id),
        ),
        const SizedBox(height: AppSpacing.md),
        ProfileEducationCard(items: profile.educationItems),
      ],
    );
  }

  void _toggleSavedCourse(BuildContext context, String id) {
    final isSaved = context.read<ProfileCubit>().toggleSavedCourse(id);
    _showMessage(context, isSaved ? 'courses.saved' : 'courses.unsaved');
  }

  void _toggleSavedJob(BuildContext context, String id) {
    final isSaved = context.read<ProfileCubit>().toggleSavedJob(id);
    _showMessage(context, isSaved ? 'profile.jobSaved' : 'profile.jobUnsaved');
  }

  Future<void> _openEditProfile(BuildContext context) async {
    final updated = await Navigator.pushNamed(context, AppRoutes.editProfile);
    if (updated == true && context.mounted) {
      await context.read<ProfileCubit>().loadProfile();
    }
  }

  void _showMessage(BuildContext context, String messageKey) {
    CustomSnackbar.showInfoKey(context: context, messageKey: messageKey);
  }
}
