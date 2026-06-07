import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../dummy_data_model.dart';

class RecentSearchItem extends StatelessWidget {
  final RecentSearchModel item;
  const RecentSearchItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: EdgeInsets.only(bottom: AppSpacing.sm.h),
      child: Row(
        children: [
          Icon(
            Icons.history_rounded,
            size: 18.sp,
            color: colorScheme.onSurfaceVariant,
          ),
          SizedBox(width: AppSpacing.sm.w),
          Text(
            item.query,
            style: AppTextStyles.bodyMedium(colorScheme.onSurface)
                .copyWith(fontSize: 14.sp),
          ),
        ],
      ),
    );
  }
}
