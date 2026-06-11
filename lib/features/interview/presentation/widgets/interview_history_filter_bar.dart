import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';

class InterviewHistoryFilterBar extends StatelessWidget {
  const InterviewHistoryFilterBar({
    required this.selectedIndex,
    required this.onChanged,
    super.key,
  });

  final int selectedIndex;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Wrap(
      spacing: AppSpacing.sm.w,
      runSpacing: AppSpacing.sm.h,
      children: [
        _HistoryFilterChip(
          label: 'interview.allFilter'.tr(),
          selected: selectedIndex == 0,
          onSelected: () => onChanged(0),
          colorScheme: colorScheme,
        ),
        _HistoryFilterChip(
          label: 'interview.technicalFilter'.tr(),
          selected: selectedIndex == 1,
          onSelected: () => onChanged(1),
          colorScheme: colorScheme,
        ),
        _HistoryFilterChip(
          label: 'interview.behavioralFilter'.tr(),
          selected: selectedIndex == 2,
          onSelected: () => onChanged(2),
          colorScheme: colorScheme,
        ),
      ],
    );
  }
}

class _HistoryFilterChip extends StatelessWidget {
  const _HistoryFilterChip({
    required this.label,
    required this.selected,
    required this.onSelected,
    required this.colorScheme,
  });

  final String label;
  final bool selected;
  final VoidCallback onSelected;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) => onSelected(),
      showCheckmark: false,
      labelStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: selected ? colorScheme.onPrimary : colorScheme.onSurface,
            fontWeight: FontWeight.w700,
          ),
      backgroundColor: colorScheme.primaryContainer.withValues(alpha: 0.45),
      selectedColor: colorScheme.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.pill),
        side: BorderSide(
          color: selected ? colorScheme.primary : Colors.transparent,
        ),
      ),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
    );
  }
}
