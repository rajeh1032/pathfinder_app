import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/routing/app_routes.dart';
import '../../../../core/routing/route_arguments.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_shadows.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/course.dart';
import '../cubit/saved_courses_cubit.dart';
import '../cubit/saved_courses_state.dart';

/// Compact saved-courses preview for the profile tab: shows up to two saved
/// courses with a "View All" action. Backed by the `/saved` endpoint.
class SavedCoursesPreviewSection extends StatelessWidget {
  const SavedCoursesPreviewSection({super.key, this.maxItems = 2});

  final int maxItems;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return BlocBuilder<SavedCoursesCubit, SavedCoursesState>(
      builder: (context, state) {
        if (state.isLoading && state.courses.isEmpty) {
          return const _SectionShell(child: _LoadingRow());
        }

        if (state.isFailure && state.courses.isEmpty) {
          return _SectionShell(
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    state.errorMessage ?? 'common.error'.tr(),
                    style: AppTextStyles.bodyMedium(colors.onSurfaceVariant),
                  ),
                ),
                TextButton(
                  onPressed: context.read<SavedCoursesCubit>().load,
                  child: Text('common.retry'.tr()),
                ),
              ],
            ),
          );
        }

        final courses = state.courses.take(maxItems).toList();

        return _SectionShell(
          onViewAll: () => Navigator.pushNamed(context, AppRoutes.courses),
          child: courses.isEmpty
              ? Text(
                  'profile.noSavedCourses'.tr(),
                  style: AppTextStyles.bodyMedium(colors.onSurfaceVariant),
                )
              : Column(
                  children: [
                    for (var i = 0; i < courses.length; i++) ...[
                      _SavedCourseTile(course: courses[i]),
                      if (i != courses.length - 1)
                        const SizedBox(height: AppSpacing.sm),
                    ],
                  ],
                ),
        );
      },
    );
  }
}

class _SectionShell extends StatelessWidget {
  const _SectionShell({required this.child, this.onViewAll});

  final Widget child;
  final VoidCallback? onViewAll;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: colors.outlineVariant.withValues(alpha: .7)),
        boxShadow: AppShadows.card,
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.bookmark_border, color: colors.primary, size: 20),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(
                    'profile.savedCourses'.tr(),
                    style: AppTextStyles.titleSmall(colors.primary),
                  ),
                ),
                if (onViewAll != null)
                  TextButton(
                    onPressed: onViewAll,
                    child: Text('profile.viewAll'.tr()),
                  ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            child,
          ],
        ),
      ),
    );
  }
}

class _LoadingRow extends StatelessWidget {
  const _LoadingRow();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: AppSpacing.md),
      child: Center(child: CircularProgressIndicator()),
    );
  }
}

class _SavedCourseTile extends StatelessWidget {
  const _SavedCourseTile({required this.course});

  final Course course;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final subtitle = [course.provider, course.category]
        .where((v) => v != null && v.trim().isNotEmpty)
        .join(' • ');

    return InkWell(
      onTap: () => Navigator.pushNamed(
        context,
        AppRoutes.courseDetails,
        arguments: RouteArguments(id: course.id),
      ),
      borderRadius: BorderRadius.circular(AppRadius.md),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: colors.surfaceContainerHighest.withValues(alpha: .35),
          borderRadius: BorderRadius.circular(AppRadius.md),
          border:
              Border.all(color: colors.outlineVariant.withValues(alpha: .6)),
        ),
        child: Padding(
          padding: EdgeInsets.all(14.w),
          child: Row(
            children: [
              _Thumbnail(thumbnailUrl: course.thumbnailUrl),
              SizedBox(width: 14.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      course.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.titleSmall(colors.onSurface),
                    ),
                    if (subtitle.isNotEmpty) ...[
                      SizedBox(height: 4.h),
                      Text(
                        subtitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:
                            AppTextStyles.bodyMedium(colors.onSurfaceVariant),
                      ),
                    ],
                    if (course.level?.trim().isNotEmpty ?? false) ...[
                      SizedBox(height: 4.h),
                      Text(
                        course.level!.trim(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.labelMedium(colors.primary),
                      ),
                    ],
                  ],
                ),
              ),
              SizedBox(width: 10.w),
              Icon(Icons.bookmark, color: colors.primary),
            ],
          ),
        ),
      ),
    );
  }
}

class _Thumbnail extends StatelessWidget {
  const _Thumbnail({this.thumbnailUrl});

  final String? thumbnailUrl;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final hasImage = thumbnailUrl != null && thumbnailUrl!.trim().isNotEmpty;

    return Container(
      width: 48.w,
      height: 48.w,
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border:
            Border.all(color: colors.outlineVariant.withValues(alpha: .45)),
      ),
      clipBehavior: Clip.antiAlias,
      child: hasImage
          ? Image.network(
              thumbnailUrl!,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Icon(
                Icons.menu_book_outlined,
                color: colors.primary,
                size: 22,
              ),
            )
          : Icon(Icons.menu_book_outlined, color: colors.primary, size: 22),
    );
  }
}
