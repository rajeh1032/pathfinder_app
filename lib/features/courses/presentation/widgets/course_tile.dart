import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_cached_image.dart';
import '../../domain/entities/course.dart';

class CourseTile extends StatelessWidget {
  const CourseTile({
    required this.course,
    required this.onTap,
    required this.onSaveTap,
    this.isSaving = false,
    super.key,
  });

  final Course course;
  final VoidCallback onTap;
  final VoidCallback onSaveTap;
  final bool isSaving;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(AppRadius.md),
                child: SizedBox.square(
                  dimension: 88,
                  child: course.thumbnailUrl == null
                      ? ColoredBox(
                          color: colors.surfaceContainerHighest,
                          child: Icon(Icons.school_outlined,
                              color: colors.primary),
                        )
                      : AppCachedImage(url: course.thumbnailUrl!),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
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
                    Text(
                      course.provider,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.bodySmall(colors.onSurfaceVariant),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Wrap(
                      spacing: AppSpacing.sm,
                      runSpacing: AppSpacing.xs,
                      children: _metadata(context),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            _price(context),
                            style: AppTextStyles.labelLarge(colors.primary),
                          ),
                        ),
                        Semantics(
                          button: true,
                          label: (course.isSaved
                                  ? 'courses.accessibility.unsave'
                                  : 'courses.accessibility.save')
                              .tr(args: [course.title]),
                          child: IconButton(
                            onPressed: isSaving ? null : onSaveTap,
                            icon: isSaving
                                ? const SizedBox.square(
                                    dimension: 18,
                                    child: CircularProgressIndicator(
                                        strokeWidth: 2),
                                  )
                                : Icon(course.isSaved
                                    ? Icons.bookmark
                                    : Icons.bookmark_border),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _metadata(BuildContext context) {
    final formatter = NumberFormat.decimalPattern(context.locale.toString());
    final values = <String>[
      if (course.level != null) course.level!,
      if (course.duration != null) course.duration!,
      if (course.rating != null)
        'courses.ratingValue'.tr(args: [course.rating!.toStringAsFixed(1)]),
      if (course.enrollmentCount > 0)
        'courses.enrollmentCount'
            .tr(args: [formatter.format(course.enrollmentCount)]),
      if (course.enrollment != null)
        'courses.progressValue'.tr(args: ['${course.enrollment!.progress}']),
    ];
    return values
        .map((value) => Chip(
              visualDensity: VisualDensity.compact,
              label: Text(value),
            ))
        .toList(growable: false);
  }

  String _price(BuildContext context) {
    if (course.isFree) return 'courses.free'.tr();
    if (course.price == null) return '';
    if (course.currency == null) {
      return NumberFormat.decimalPattern(context.locale.toString())
          .format(course.price);
    }
    return NumberFormat.simpleCurrency(
      locale: context.locale.toString(),
      name: course.currency,
    ).format(course.price);
  }
}
