import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_text_styles.dart';

class SearchBar extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const SearchBar({super.key, required this.controller, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      height: 42.h,
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest.withOpacity(0.5),
        borderRadius: BorderRadius.circular(AppRadius.pill.r),
        border: Border.all(color: cs.outline.withOpacity(0.15), width: 1),
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        style: AppTextStyles.bodyMedium(cs.onSurface)
            .copyWith(fontSize: 13.sp),
        decoration: InputDecoration(
          hintText: 'chatHistory.searchHint'.tr(),
          hintStyle: AppTextStyles.bodyMedium(
            cs.onSurface.withOpacity(0.4),
          ).copyWith(fontSize: 13.sp),
          prefixIcon: Icon(
            Icons.search_rounded,
            size: 18.sp,
            color: cs.onSurface.withOpacity(0.4),
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 10.h),
        ),
      ),
    );
  }
}
