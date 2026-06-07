
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../home_dummy_data.dart';

class HomeRecommendationCard extends StatelessWidget {
  final HomeRecommendationModel recommendation;

  const HomeRecommendationCard({super.key, required this.recommendation});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: colorScheme.outline.withValues(alpha: 0.5)),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: 0.06),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Label
          Text(
            'TOP RECOMMENDATION',
            style: TextStyle(
              fontSize: 10.sp,
              fontWeight: FontWeight.w700,
              color: colorScheme.onSurfaceVariant,
              letterSpacing: 1.2,
            ),
          ),
          SizedBox(height: 8.h),
          // Title + badge
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  recommendation.title,
                  style: theme.textTheme.titleLarge,
                ),
              ),
              SizedBox(width: 8.w),
              _MatchBadge(label: recommendation.badge),
            ],
          ),
          SizedBox(height: 8.h),
          // Reason
          Row(
            children: [
              Icon(
                Icons.auto_awesome,
                size: 14.sp,
                color: AppColors.primary,
              ),
              SizedBox(width: 4.w),
              Text(
                recommendation.reason,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MatchBadge extends StatelessWidget {
  final String label;

  const _MatchBadge({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999.r),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11.sp,
          fontWeight: FontWeight.w700,
          color: AppColors.primary,
        ),
      ),
    );
  }
}