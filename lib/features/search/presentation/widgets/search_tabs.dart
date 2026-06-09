import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../dummy_data_model.dart';

class SearchTabs extends StatelessWidget {
  final SearchTab selected;
  final ValueChanged<SearchTab> onChanged;

  const SearchTabs(
      {super.key, required this.selected, required this.onChanged});

  String _label(SearchTab tab) {
    switch (tab) {
      case SearchTab.all:
        return 'All';
      case SearchTab.jobs:
        return 'Jobs';
      case SearchTab.courses:
        return 'Courses';
      case SearchTab.skills:
        return 'Skills';
      case SearchTab.careerPaths:
        return 'Career Paths';
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: SearchTab.values.map((tab) {
          final isSelected = selected == tab;
          return GestureDetector(
            onTap: () => onChanged(tab),
            child: Container(
              margin: EdgeInsets.only(right: AppSpacing.sm.w),
              padding: EdgeInsets.symmetric(
                horizontal: AppSpacing.md.w,
                vertical: 7.h,
              ),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primary
                    : colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(AppRadius.pill.r),
              ),
              child: Text(
                _label(tab),
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  color:
                      isSelected ? Colors.white : colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
