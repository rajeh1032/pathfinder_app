import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_radius.dart';
import '../../../../../core/theme/app_spacing.dart';

class BoostMatchCard extends StatelessWidget {
  const BoostMatchCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSpacing.md.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF6366F1), Color(0xFF8B5CF6), Color(0xFFA855F7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppRadius.lg.r),
        boxShadow: const [
          BoxShadow(
            color: Color(0x668B5CF6),
            blurRadius: 30,
            offset: Offset(0, 18),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 46.w,
                height: 46.h,
                decoration: const BoxDecoration(
                  color: Color(0x33FFFFFF),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.bolt, color: Colors.white, size: 26.sp),
              ),
              const Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 7.h),
                decoration: BoxDecoration(
                  color: const Color(0x26FFFFFF),
                  borderRadius: BorderRadius.circular(AppRadius.pill.r),
                ),
                child: Text(
                  'jobs.matching.newUpdate'.tr(),
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                      ),
                ),
              ),
            ],
          ),
          SizedBox(height: AppSpacing.lg.h),
          Text(
            'jobs.matching.boostTitle'.tr(),
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  height: 1.12,
                ),
          ),
          SizedBox(height: AppSpacing.sm.h),
          Text(
            'jobs.matching.boostDescription'.tr(),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: const Color(0xE6FFFFFF),
                  height: 1.42,
                  fontWeight: FontWeight.w500,
                ),
          ),
          SizedBox(height: AppSpacing.xl.h),
          SizedBox(
            width: double.infinity,
            height: 52.h,
            child: FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: AppColors.primaryDark,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadius.md.r),
                ),
              ),
              onPressed: () {},
              child: Text(
                'jobs.matching.startLearningPath'.tr(),
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: AppColors.primaryDark,
                      fontWeight: FontWeight.w900,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
