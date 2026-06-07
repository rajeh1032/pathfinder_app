import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

class InterviewFormatChoice extends StatelessWidget {
  const InterviewFormatChoice({
    required this.titleKey,
    required this.descriptionKey,
    required this.icon,
    required this.color,
    required this.selected,
    required this.onTap,
    super.key,
  });

  final String titleKey;
  final String descriptionKey;
  final IconData icon;
  final Color color;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        width: double.infinity,
        padding: EdgeInsets.all(AppSpacing.md.w),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(AppRadius.lg),
          border: Border.all(
            color: selected ? colorScheme.primary : colorScheme.outlineVariant,
            width: selected ? 1.6 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: colorScheme.shadow.withValues(alpha: 0.08),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.14),
                borderRadius: BorderRadius.circular(AppRadius.sm),
              ),
              child: Icon(icon, color: color, size: 22.sp),
            ),
            SizedBox(width: AppSpacing.md.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    titleKey.tr(),
                    style: AppTextStyles.titleMedium(colorScheme.onSurface)
                        .copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: AppSpacing.xs.h),
                  Text(
                    descriptionKey.tr(),
                    style: AppTextStyles.bodyMedium(
                      colorScheme.onSurfaceVariant,
                    ).copyWith(height: 1.45),
                  ),
                ],
              ),
            ),
            if (selected) Icon(Icons.check_circle, color: colorScheme.primary),
          ],
        ),
      ),
    );
  }
}
