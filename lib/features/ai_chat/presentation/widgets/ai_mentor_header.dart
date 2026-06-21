import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

class AiMentorHeader extends StatelessWidget {
  const AiMentorHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Row(
      children: [
        Container(
          width: 36.w,
          height: 36.w,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.primary, AppColors.tertiary],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.smart_toy_rounded,
              size: 18.sp, color: Colors.white),
        ),
        SizedBox(width: AppSpacing.sm.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'aiChat.mentorName'.tr(),
              style: AppTextStyles.bodyMedium(cs.onSurface).copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 14.sp,
              ),
            ),
            Text(
              'aiChat.mentorSubtitle'.tr(),
              style: AppTextStyles.labelSmall(
                cs.onSurface.withOpacity(0.5),
              ).copyWith(fontSize: 10.sp),
            ),
          ],
        ),
      ],
    );
  }
}
