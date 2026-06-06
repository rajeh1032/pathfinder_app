import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_colors.dart';
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
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF240917), Color(0xFF0B2438)],
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
                color: AppColors.neutral900,
                borderRadius: BorderRadius.circular(AppRadius.sm.r),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x99000000),
                    blurRadius: 22,
                    offset: Offset(0, 14),
                  ),
                ],
              ),
              child: Column(
                children: const [
                  CodeLine(widthFactor: .72, color: AppColors.secondary),
                  CodeLine(widthFactor: .88, color: AppColors.primarySoft),
                  CodeLine(widthFactor: .56, color: AppColors.warning),
                  CodeLine(widthFactor: .8, color: AppColors.tertiary),
                  CodeLine(widthFactor: .62, color: AppColors.neutral300),
                ],
              ),
            ),
          ),
          Positioned(
            left: AppSpacing.md.w,
            top: AppSpacing.sm.h,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(AppRadius.pill.r),
              ),
              child: Row(
                children: [
                  Icon(Icons.auto_awesome,
                      size: 13.sp, color: AppColors.tertiary),
                  SizedBox(width: 4.w),
                  Text(
                    'jobs.details.aiRecommended'.tr(),
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: AppColors.tertiaryDark,
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
