import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/course.dart';

class CourseEnrollBar extends StatelessWidget {
  const CourseEnrollBar({
    required this.course,
    required this.isSaved,
    required this.isEnrolled,
    required this.onSaveTap,
    required this.onEnrollTap,
    super.key,
  });

  final Course course;
  final bool isSaved;
  final bool isEnrolled;
  final VoidCallback onSaveTap;
  final VoidCallback onEnrollTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final buttonWidth = 132.6.w;

    return SafeArea(
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: colors.surface,
          border: Border(top: BorderSide(color: colors.outlineVariant)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'courses.totalPrice'.tr(),
                      style: AppTextStyles.labelSmall(
                        colors.onSurfaceVariant,
                      ),
                    ),
                    Text(
                      course.priceKey.tr(),
                      style: AppTextStyles.titleLarge(colors.onSurface),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: onSaveTap,
                child: Icon(isSaved ? Icons.bookmark : Icons.bookmark_border),
              ),
              const SizedBox(width: AppSpacing.sm),
              SizedBox(
                width: buttonWidth,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(0, 52),
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                    ),
                  ),
                  onPressed: onEnrollTap,
                  child: Text(
                    (isEnrolled ? 'courses.enrolledCta' : 'courses.enrollNow')
                        .tr(),
                    overflow: TextOverflow.ellipsis,
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
