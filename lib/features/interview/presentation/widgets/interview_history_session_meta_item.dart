import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_text_styles.dart';

class InterviewHistorySessionMetaItem extends StatelessWidget {
  const InterviewHistorySessionMetaItem({
    required this.icon,
    required this.label,
    super.key,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 18.sp, color: colorScheme.onSurfaceVariant),
        SizedBox(width: 6.w),
        Text(
          label,
          style: AppTextStyles.bodyMedium(colorScheme.onSurfaceVariant),
        ),
      ],
    );
  }
}
