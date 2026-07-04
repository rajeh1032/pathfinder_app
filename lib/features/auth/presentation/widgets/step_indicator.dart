import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_text_styles.dart';

class StepIndicator extends StatelessWidget {
  final int currentStep;
  final List<String> labels;

  const StepIndicator(
      {super.key, required this.currentStep, required this.labels});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final children = <Widget>[];

    for (var i = 0; i < labels.length; i++) {
      final isActive = i == currentStep;
      final isDone = i < currentStep;
      final isLast = i == labels.length - 1;

      children.add(
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 28.w,
              height: 28.w,
              decoration: BoxDecoration(
                color: isActive || isDone
                    ? colorScheme.primary
                    : colorScheme.surfaceContainerHighest,
                shape: BoxShape.circle,
                border: isActive
                    ? Border.all(
                        color: colorScheme.primary.withAlpha(76),
                        width: 3,
                      )
                    : null,
              ),
              child: Center(
                child: isDone
                    ? Icon(
                        Icons.check_rounded,
                        size: 14.sp,
                        color: Colors.white,
                      )
                    : Text(
                        '${i + 1}',
                        style: AppTextStyles.labelSmall(
                          isActive
                              ? Colors.white
                              : colorScheme.onSurfaceVariant,
                        ).copyWith(fontWeight: FontWeight.w700),
                      ),
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              labels[i],
              style: AppTextStyles.labelSmall(
                isActive ? colorScheme.primary : colorScheme.onSurfaceVariant,
              ).copyWith(
                fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                fontSize: 10.sp,
              ),
            ),
          ],
        ),
      );

      if (!isLast) {
        children.add(
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 32.w,
              height: 1.5,
              color: isDone ? colorScheme.primary : colorScheme.outline,
            ),
          ),
        );
      }
    }

    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: children,
      ),
    );
  }
}
