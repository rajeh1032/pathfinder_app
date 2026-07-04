import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_cached_image.dart';
import '../../domain/entities/course.dart';
import '../../domain/entities/course_enrollment.dart';
import 'enrollment_editor.dart';

class CourseDetailsContent extends StatelessWidget {
  const CourseDetailsContent({
    required this.course,
    required this.progress,
    required this.status,
    required this.isDirty,
    required this.isUpdating,
    required this.onProgress,
    required this.onStatus,
    required this.onUpdate,
    required this.onOpenProvider,
    super.key,
  });

  final Course course;
  final int? progress;
  final EnrollmentStatus? status;
  final bool isDirty;
  final bool isUpdating;
  final ValueChanged<int> onProgress;
  final ValueChanged<EnrollmentStatus> onStatus;
  final VoidCallback onUpdate;
  final VoidCallback onOpenProvider;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return ListView(
      padding: const EdgeInsets.only(bottom: AppSpacing.xxl),
      children: [
        SizedBox(
          height: 220,
          child: course.thumbnailUrl == null
              ? ColoredBox(
                  color: colors.surfaceContainerHighest,
                  child: Icon(Icons.school_outlined,
                      size: 72, color: colors.primary),
                )
              : AppCachedImage(url: course.thumbnailUrl!),
        ),
        Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(course.title,
                  style: AppTextStyles.headlineMedium(colors.onSurface)),
              const SizedBox(height: AppSpacing.xs),
              Text(course.provider,
                  style: AppTextStyles.bodyMedium(colors.onSurfaceVariant)),
              const SizedBox(height: AppSpacing.md),
              Wrap(
                spacing: AppSpacing.sm,
                runSpacing: AppSpacing.sm,
                children: _metadata(context),
              ),
              if (course.description != null) ...[
                const SizedBox(height: AppSpacing.xl),
                _Section(
                    titleKey: 'courses.about',
                    child: Text(course.description!)),
              ],
              if (course.skills.isNotEmpty) ...[
                const SizedBox(height: AppSpacing.xl),
                _Section(
                  titleKey: 'courses.skills',
                  child: Wrap(
                    spacing: AppSpacing.sm,
                    runSpacing: AppSpacing.sm,
                    children: course.skills
                        .map((skill) => Chip(label: Text(skill.name)))
                        .toList(growable: false),
                  ),
                ),
              ],
              if (course.learningOutcomes.isNotEmpty) ...[
                const SizedBox(height: AppSpacing.xl),
                _Section(
                  titleKey: 'courses.learningOutcomes',
                  child: Column(
                    children: course.learningOutcomes
                        .map((outcome) => Padding(
                              padding:
                                  const EdgeInsets.only(bottom: AppSpacing.sm),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(Icons.check_circle_outline,
                                      size: 18, color: colors.primary),
                                  const SizedBox(width: AppSpacing.sm),
                                  Expanded(child: Text(outcome)),
                                ],
                              ),
                            ))
                        .toList(growable: false),
                  ),
                ),
              ],
              const SizedBox(height: AppSpacing.xl),
              OutlinedButton.icon(
                onPressed: onOpenProvider,
                icon: const Icon(Icons.open_in_new),
                label: Text('courses.openProvider'.tr()),
              ),
              if (course.enrollment != null) ...[
                const SizedBox(height: AppSpacing.xl),
                EnrollmentEditor(
                  progress: progress!,
                  status: status!,
                  isDirty: isDirty,
                  isLoading: isUpdating,
                  onProgress: onProgress,
                  onStatus: onStatus,
                  onUpdate: onUpdate,
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  List<Widget> _metadata(BuildContext context) {
    final decimal = NumberFormat.decimalPattern(context.locale.toString());
    final values = <String>[
      _price(context),
      if (course.duration != null) course.duration!,
      if (course.level != null) course.level!,
      if (course.rating != null)
        'courses.ratingValue'.tr(args: [course.rating!.toStringAsFixed(1)]),
      if (course.reviewsCount > 0)
        'courses.reviewsCount'.tr(args: [decimal.format(course.reviewsCount)]),
      if (course.enrollmentCount > 0)
        'courses.enrollmentCount'
            .tr(args: [decimal.format(course.enrollmentCount)]),
    ].where((value) => value.isNotEmpty).toList();
    return values
        .map((value) => Chip(label: Text(value)))
        .toList(growable: false);
  }

  String _price(BuildContext context) {
    if (course.isFree) return 'courses.free'.tr();
    if (course.price == null) return '';
    if (course.currency == null) {
      return NumberFormat.decimalPattern(
        context.locale.toString(),
      ).format(course.price);
    }
    return NumberFormat.simpleCurrency(
      locale: context.locale.toString(),
      name: course.currency,
    ).format(course.price);
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.titleKey, required this.child});
  final String titleKey;
  final Widget child;

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(titleKey.tr(), style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: AppSpacing.sm),
          child,
        ],
      );
}
