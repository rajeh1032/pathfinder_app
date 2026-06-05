import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_gradient_title.dart';
import '../../domain/entities/roadmap_course_recommendation.dart';
import '../cubit/roadmaps_cubit.dart';
import '../cubit/roadmaps_state.dart';
import 'roadmaps_categories.dart';
import 'roadmaps_progress.dart';
import 'roadmaps_search_filters.dart';
import 'roadmaps_top_picks.dart';
import 'roadmaps_trending.dart';

class RoadmapsBody extends StatelessWidget {
  const RoadmapsBody({
    required this.recommendations,
    required this.query,
    required this.selectedFilter,
    required this.selectedCategoryKey,
    required this.savedCourseIds,
    super.key,
  });

  final List<RoadmapCourseRecommendation> recommendations;
  final String query;
  final RoadmapsFilter selectedFilter;
  final String? selectedCategoryKey;
  final Set<String> savedCourseIds;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          automaticallyImplyLeading: false,
          backgroundColor: colors.surface,
          title: const AppGradientTitle(),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.lg,
            AppSpacing.lg,
            AppSpacing.lg,
            AppSpacing.xxl,
          ),
          sliver: SliverList.list(
            children: [
              RoadmapsSearchFilters(
                query: query,
                selectedFilter: selectedFilter,
              ),
              const SizedBox(height: AppSpacing.xl),
              const RoadmapsProgress(),
              const SizedBox(height: AppSpacing.xl),
              RoadmapsTopPicks(
                recommendations: recommendations,
                savedCourseIds: savedCourseIds,
                onSaveTap: (courseId) => _toggleSaved(context, courseId),
              ),
              const SizedBox(height: AppSpacing.xl),
              RoadmapsCategories(selectedCategoryKey: selectedCategoryKey),
              const SizedBox(height: AppSpacing.xl),
              const RoadmapsTrending(),
            ],
          ),
        ),
      ],
    );
  }

  void _toggleSaved(BuildContext context, String courseId) {
    final isSaved = context.read<RoadmapsCubit>().toggleSavedCourse(courseId);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          (isSaved ? 'courses.saved' : 'courses.unsaved').tr(),
        ),
      ),
    );
  }
}
