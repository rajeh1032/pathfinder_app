import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_radius.dart';

class AiMatchPill extends StatelessWidget {
  const AiMatchPill({
    super.key,
    required this.percentage,
  });

  final int percentage;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: _pillTint(context, colorScheme.primary, alpha: .12),
        borderRadius: BorderRadius.circular(AppRadius.pill.r),
        border: Border.all(color: colorScheme.primary.withValues(alpha: .38)),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: .12),
            blurRadius: 18,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.auto_awesome, color: colorScheme.primary, size: 16.sp),
          SizedBox(width: 5.w),
          Text(
            'AI Match: $percentage%',
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: colorScheme.primary,
                  fontWeight: FontWeight.w900,
                ),
          ),
        ],
      ),
    );
  }
}

Color _pillTint(BuildContext context, Color tint, {required double alpha}) {
  return Color.alphaBlend(
    tint.withValues(alpha: alpha),
    Theme.of(context).colorScheme.surface,
  );
}
