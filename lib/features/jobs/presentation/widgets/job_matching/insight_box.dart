import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_radius.dart';
import '../../../../../core/theme/app_spacing.dart';

class JobInsightBox extends StatelessWidget {
  const JobInsightBox({
    super.key,
    required this.message,
    this.onTap,
  });

  final String message;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final borderRadius = BorderRadius.circular(AppRadius.md.r);

    return Material(
      color: colorScheme.primaryContainer.withValues(alpha: .55),
      borderRadius: borderRadius,
      child: InkWell(
        onTap: onTap,
        borderRadius: borderRadius,
        child: Container(
          padding: EdgeInsets.all(AppSpacing.md.w),
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            border: Border.all(color: colorScheme.outlineVariant),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.psychology_outlined,
                color: colorScheme.onPrimaryContainer,
                size: 24.sp,
              ),
              SizedBox(width: AppSpacing.sm.w),
              Expanded(
                child: Text(
                  message,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onPrimaryContainer,
                        height: 1.42,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
              if (onTap != null) ...[
                SizedBox(width: AppSpacing.xs.w),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: colorScheme.onPrimaryContainer,
                  size: 16.sp,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
