import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../model_chat_ai_history.dart';

class SessionCard extends StatelessWidget {
  final ChatSessionModel session;
  final VoidCallback onTap;

  const SessionCard({super.key, required this.session, required this.onTap});


  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final gradient = AppColors.avatarGradient(session.id);

    return InkWell(
      onTap: onTap,
      child: Container(
        // Active session: left border accent
        decoration: BoxDecoration(
          border: session.isActive
              ? Border(
            left: BorderSide(
              color: AppColors.primary,
              width: 3.w,
            ),
          )
              : null,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.md.w,
          vertical: AppSpacing.sm.h + 2.h,
        ),
        child: Row(
          children: [
            Stack(
              children: [
                Container(
                  width: 46.w,
                  height: 46.w,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: gradient,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.smart_toy_rounded,
                    size: 22.sp,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
                // Active green dot
                if (session.isActive)
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 11.w,
                      height: 11.w,
                      decoration: BoxDecoration(
                        color: AppColors.success,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: cs.surface,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(width: AppSpacing.sm.w + 2.w),

            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title + date
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          session.title,
                          style:
                          AppTextStyles.bodyMedium(cs.onSurface).copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 13.5.sp,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(width: AppSpacing.xs.w),
                      Text(
                        session.date,
                        style: AppTextStyles.labelSmall(
                          cs.onSurface.withOpacity(0.4),
                        ).copyWith(fontSize: 11.sp),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),

                  // Active badge + message count
                  Row(
                    children: [
                      // "Active" green badge
                      if (session.isActive) ...[
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 7.w,
                            vertical: 2.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.success.withOpacity(0.15),
                            borderRadius:
                            BorderRadius.circular(AppRadius.pill.r),
                          ),
                          child: Text(
                            'Active',
                            style: AppTextStyles.labelSmall(
                              AppColors.success,
                            ).copyWith(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(width: 6.w),
                      ],

                      // Message count chip
                      Icon(
                        Icons.chat_bubble_outline_rounded,
                        size: 11.sp,
                        color: cs.onSurface.withOpacity(0.4),
                      ),
                      SizedBox(width: 3.w),
                      Text(
                        '${session.messageCount} ${'chatHistory.messages'.tr()}',
                        style: AppTextStyles.labelSmall(
                          cs.onSurface.withOpacity(0.45),
                        ).copyWith(fontSize: 11.sp),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Arrow
            Icon(
              Icons.chevron_right_rounded,
              size: 20.sp,
              color: cs.onSurface.withOpacity(0.3),
            ),
          ],
        ),
      ),
    );
  }
}
