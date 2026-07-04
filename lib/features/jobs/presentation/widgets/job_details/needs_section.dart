import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_spacing.dart';
import 'section.dart';

class NeedsSection extends StatelessWidget {
  const NeedsSection({
    super.key,
    required this.items,
  });

  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return DetailsSection(
      title: 'jobs.details.needsTitle'.tr(),
      child: Column(
        children: items.map((item) => NeedItem(text: item)).toList(),
      ),
    );
  }
}

class NeedItem extends StatelessWidget {
  const NeedItem({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: AppSpacing.sm.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.check_circle_outline,
              size: 18.sp, color: Theme.of(context).colorScheme.primary),
          SizedBox(width: AppSpacing.sm.w),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                    height: 1.35,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
