import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/routing/app_routes.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_gradients.dart';
import '../../../../../core/theme/app_radius.dart';
import '../../../../../core/theme/app_spacing.dart';

class ApplyBottomBar extends StatelessWidget {
  const ApplyBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        AppSpacing.md.w,
        AppSpacing.sm.h,
        AppSpacing.md.w,
        MediaQuery.paddingOf(context).bottom + AppSpacing.sm.h,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0x14111827),
            blurRadius: 22,
            offset: Offset(0, -8),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48.w,
            height: 48.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(AppRadius.md.r),
              border: Border.all(color: AppColors.primaryContainer),
            ),
            child:
                const Icon(Icons.bookmark_border, color: AppColors.primaryDark),
          ),
          SizedBox(width: AppSpacing.md.w),
          Expanded(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: AppGradients.aiTertiary,
                borderRadius: BorderRadius.circular(AppRadius.md.r),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x336366F1),
                    blurRadius: 14,
                    offset: Offset(0, 8),
                  ),
                ],
              ),
              child: SizedBox(
                height: 50.h,
                child: TextButton(
                  onPressed: () => Navigator.of(context)
                      .pushNamed(AppRoutes.coverLetterGenerator),
                  child: Text(
                    'jobs.common.applyNow'.tr(),
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                        ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
