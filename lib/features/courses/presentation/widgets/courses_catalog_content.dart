import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/utils/custom_button.dart';
import '../../domain/entities/course.dart';
import '../cubit/courses_catalog_state.dart';
import 'course_tile.dart';
import 'recommendation_details.dart';

class CoursesCatalogContent extends StatelessWidget {
  const CoursesCatalogContent({
    required this.state,
    required this.onRefresh,
    required this.onLoadMore,
    required this.onSave,
    required this.onOpen,
    super.key,
  });

  final CoursesCatalogState state;
  final Future<void> Function() onRefresh;
  final Future<void> Function() onLoadMore;
  final ValueChanged<Course> onSave;
  final ValueChanged<Course> onOpen;

  @override
  Widget build(BuildContext context) {
    final courses = state.visibleCourses;
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification.metrics.extentAfter < 240) onLoadMore();
          return false;
        },
        child: ListView.separated(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.lg,
            AppSpacing.sm,
            AppSpacing.lg,
            AppSpacing.xxl,
          ),
          itemCount: courses.length + (state.isLoadingMore ? 1 : 0),
          separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.md),
          itemBuilder: (context, index) {
            if (index == courses.length) {
              return const Center(child: CircularProgressIndicator());
            }
            final course = courses[index];
            final tile = CourseTile(
              course: course,
              isSaving: state.savingIds.contains(course.id),
              onSaveTap: () => onSave(course),
              onTap: () => onOpen(course),
            );
            if (state.tab != CoursesCatalogTab.recommended) return tile;
            final recommendation = state.recommendations[index];
            return Card(
              margin: EdgeInsets.zero,
              child: Column(
                children: [
                  tile,
                  RecommendationDetails(recommendation: recommendation),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class CoursesUploadCvView extends StatelessWidget {
  const CoursesUploadCvView({required this.onPressed, super.key});
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            children: [
              const Icon(Icons.description_outlined, size: 64),
              const SizedBox(height: AppSpacing.md),
              Text(
                'courses.uploadCvTitle'.tr(),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text('courses.uploadCvBody'.tr(), textAlign: TextAlign.center),
              const SizedBox(height: AppSpacing.lg),
              CustomButton(
                labelKey: 'courses.uploadCvAction',
                onPressed: onPressed,
              ),
            ],
          ),
        ),
      );
}
