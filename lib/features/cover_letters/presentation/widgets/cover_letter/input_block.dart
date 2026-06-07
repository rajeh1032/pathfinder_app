import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_radius.dart';
import '../../../../../core/theme/app_spacing.dart';
import 'shared_widgets.dart';

class InputBlock extends StatelessWidget {
  const InputBlock({super.key, required this.label, required this.hint});

  final String label;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FieldLabel(label),
        SizedBox(height: AppSpacing.xs.h),
        Container(
          width: double.infinity,
          constraints: BoxConstraints(minHeight: 72.h),
          padding: EdgeInsets.all(10.w),
          decoration: BoxDecoration(
            color: AppColors.neutral50,
            borderRadius: BorderRadius.circular(AppRadius.sm.r),
            border: Border.all(color: AppColors.lightBorder),
          ),
          child: Text(
            hint,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.neutral500,
                  height: 1.35,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ),
      ],
    );
  }
}
