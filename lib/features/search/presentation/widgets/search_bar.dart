import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';

class SearchBarWidget extends StatelessWidget {
  final TextEditingController controller;
  const SearchBarWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      height: 48.h,
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(AppRadius.md.r),
        border: Border.all(color: colorScheme.outline.withValues(alpha: 0.4)),
      ),
      child: Row(
        children: [
          SizedBox(width: AppSpacing.md.w),
          Icon(
            Icons.search_rounded,
            size: 20.sp,
            color: colorScheme.onSurfaceVariant,
          ),
          SizedBox(width: AppSpacing.sm.w),
          Expanded(
            child: TextField(
              controller: controller,
              style: TextStyle(
                fontSize: 13.sp,
                color: colorScheme.onSurface,
              ),
              decoration: InputDecoration(
                hintText: 'Search jobs, courses, skills, career paths...',
                hintStyle: TextStyle(
                  fontSize: 12.sp,
                  color: colorScheme.onSurfaceVariant,
                ),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          // Filter icon
          Container(
            margin: EdgeInsets.all(6.w),
            padding: EdgeInsets.all(6.w),
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(AppRadius.sm.r),
            ),
            child: Icon(
              Icons.tune_rounded,
              size: 16.sp,
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
