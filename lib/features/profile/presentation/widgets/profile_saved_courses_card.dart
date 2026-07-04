import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/profile.dart';
import 'profile_section_card.dart';

class ProfileSavedCoursesCard extends StatelessWidget {
  const ProfileSavedCoursesCard({
    required this.courses,
    required this.savedCourseIds,
    required this.onToggleSaved,
    super.key,
  });

  final List<ProfileSavedCourse> courses;
  final Set<String> savedCourseIds;
  final ValueChanged<String> onToggleSaved;

  @override
  Widget build(BuildContext context) {
    return ProfileSectionCard(
      icon: Icons.bookmark_border,
      titleKey: 'profile.savedCourses',
      trailing: TextButton(
        onPressed: () => Navigator.pushNamed(context, AppRoutes.courses),
        child: Text(context.tr('profile.viewAll')),
      ),
      children: [
        SizedBox(
          height: 208,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: courses.length,
            separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.md),
            itemBuilder: (context, index) {
              return _SavedCourseTile(
                course: courses[index],
                isSaved: savedCourseIds.contains(courses[index].id),
                onToggleSaved: onToggleSaved,
              );
            },
          ),
        ),
      ],
    );
  }
}

class _SavedCourseTile extends StatelessWidget {
  const _SavedCourseTile({
    required this.course,
    required this.isSaved,
    required this.onToggleSaved,
  });

  final ProfileSavedCourse course;
  final bool isSaved;
  final ValueChanged<String> onToggleSaved;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return SizedBox(
      width: 156,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: colors.surfaceContainerHighest.withValues(alpha: .5),
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(color: colors.outlineVariant),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.sm),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(AppRadius.sm),
                child: Image.asset(
                  course.imageAsset,
                  width: double.infinity,
                  height: 78,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                context.tr(course.titleKey),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.labelMedium(colors.onSurface),
              ),
              Text(
                context.tr(course.providerKey),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.bodySmall(colors.onSurfaceVariant),
              ),
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: IconButton(
                  padding: EdgeInsets.zero,
                  visualDensity: VisualDensity.compact,
                  constraints: const BoxConstraints(
                    minWidth: 32,
                    minHeight: 32,
                  ),
                  onPressed: () => onToggleSaved(course.id),
                  icon: Icon(
                    isSaved ? Icons.bookmark : Icons.bookmark_border,
                    color: colors.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
