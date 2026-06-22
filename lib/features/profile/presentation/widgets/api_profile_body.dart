import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/routing/app_routes.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../courses/presentation/cubit/saved_courses_cubit.dart';
import '../../../courses/presentation/widgets/saved_courses_preview_section.dart';
import '../../../jobs/presentation/cubit/saved_jobs_cubit.dart';
import '../../../jobs/presentation/widgets/saved_jobs/saved_jobs_preview_section.dart';
import '../../../roadmaps/presentation/cubit/roadmaps_cubit.dart';
import '../../../roadmaps/presentation/widgets/roadmap_preview_section.dart';
import '../cubit/my_profile_cubit.dart';
import '../cubit/my_profile_state.dart';
import 'api_profile_education_card.dart';
import 'api_profile_experience_card.dart';
import 'api_profile_header.dart';
import 'api_profile_info_card.dart';

/// Profile body rendered from the live Profiles API.
class ApiProfileBody extends StatelessWidget {
  const ApiProfileBody({required this.state, super.key});

  final MyProfileState state;

  @override
  Widget build(BuildContext context) {
    final profile = state.profile;
    if (profile == null) return const SizedBox.shrink();

    return RefreshIndicator(
      onRefresh: () async {
        await Future.wait([
          context.read<MyProfileCubit>().load(),
          context.read<SavedCoursesCubit>().load(),
          context.read<SavedJobsCubit>().load(),
          context.read<RoadmapsCubit>().loadMyRoadmap(),
        ]);
      },
      child: ListView(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.lg,
          AppSpacing.lg,
          AppSpacing.lg,
          AppSpacing.xxl,
        ),
        children: [
          ApiProfileHeader(
            profile: profile,
            onEditPhoto: () => _openEditProfile(context),
          ),
          const SizedBox(height: AppSpacing.lg),
          ApiProfileInfoCard(profile: profile),
          const SizedBox(height: AppSpacing.md),
          ApiProfileExperienceCard(experiences: state.experiences),
          const SizedBox(height: AppSpacing.md),
          ApiProfileEducationCard(items: state.education),
          const SizedBox(height: AppSpacing.md),
          const RoadmapPreviewSection(),
          const SizedBox(height: AppSpacing.md),
          const SavedCoursesPreviewSection(),
          const SizedBox(height: AppSpacing.md),
          const SavedJobsPreviewSection(),
        ],
      ),
    );
  }

  Future<void> _openEditProfile(BuildContext context) async {
    final updated = await Navigator.pushNamed(context, AppRoutes.editProfile);
    if (updated == true && context.mounted) {
      await context.read<MyProfileCubit>().load();
    }
  }
}
