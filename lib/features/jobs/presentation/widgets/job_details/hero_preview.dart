import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_radius.dart';
import '../../../../../core/theme/app_spacing.dart';

class JobHeroPreview extends StatelessWidget {
  const JobHeroPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180.h,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.inverseSurface,
                  Theme.of(context).colorScheme.surfaceContainerHighest,
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
          ),
          Positioned(
            left: 54.w,
            right: 36.w,
            top: 26.h,
            child: Container(
              height: 116.h,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onSurface,
                borderRadius: BorderRadius.circular(AppRadius.sm.r),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context)
                        .colorScheme
                        .shadow
                        .withValues(alpha: .55),
                    blurRadius: 22,
                    offset: Offset(0, 14),
                  ),
                ],
              ),
              child: Column(
                children: [
                  CodeLine(
                      widthFactor: .72,
                      color: Theme.of(context).colorScheme.secondary),
                  CodeLine(
                      widthFactor: .88,
                      color: Theme.of(context).colorScheme.primaryContainer),
                  CodeLine(
                      widthFactor: .56,
                      color: Theme.of(context).colorScheme.tertiary),
                  CodeLine(
                      widthFactor: .8,
                      color: Theme.of(context).colorScheme.tertiary),
                  CodeLine(
                      widthFactor: .62,
                      color: Theme.of(context).colorScheme.outlineVariant),
                ],
              ),
            ),
          ),
          Positioned(
            left: AppSpacing.md.w,
            top: AppSpacing.sm.h,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: _pillTint(
                  context,
                  Theme.of(context).colorScheme.tertiary,
                  alpha: .12,
                ),
                borderRadius: BorderRadius.circular(AppRadius.pill.r),
                border: Border.all(
                  color: Theme.of(context)
                      .colorScheme
                      .tertiary
                      .withValues(alpha: .42),
                ),
              ),
              child: Row(
                children: [
                  Icon(Icons.auto_awesome,
                      size: 13.sp,
                      color: Theme.of(context).colorScheme.tertiary),
                  SizedBox(width: 4.w),
                  Text(
                    'jobs.details.aiRecommended'.tr(),
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: Theme.of(context).colorScheme.tertiary,
                          fontWeight: FontWeight.w900,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Color _pillTint(BuildContext context, Color tint, {required double alpha}) {
  return Color.alphaBlend(
    tint.withValues(alpha: alpha),
    Theme.of(context).colorScheme.surface,
  );
}

class CodeLine extends StatelessWidget {
  const CodeLine({super.key, required this.widthFactor, required this.color});

  final double widthFactor;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: FractionallySizedBox(
        widthFactor: widthFactor,
        child: Container(
          height: 5.h,
          margin: EdgeInsets.fromLTRB(18.w, 12.h, 18.w, 0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: .78),
            borderRadius: BorderRadius.circular(AppRadius.pill.r),
          ),
        ),
      ),
    );
  }
}
