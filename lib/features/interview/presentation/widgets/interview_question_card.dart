import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

class InterviewQuestionCard extends StatelessWidget {
  const InterviewQuestionCard({
    required this.colorScheme,
    required this.question,
    required this.options,
    required this.selectedOptionIndex,
    required this.onOptionSelected,
    this.isEnabled = true,
    super.key,
  });

  final ColorScheme colorScheme;
  final String question;
  final List<String> options;
  final int? selectedOptionIndex;
  final ValueChanged<int> onOptionSelected;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSpacing.lg.w),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: colorScheme.outlineVariant),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: 0.08),
            blurRadius: 24.r,
            offset: Offset(0, 12.h),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question,
            style: AppTextStyles.titleLarge(colorScheme.onSurface).copyWith(
              height: 1.45,
            ),
          ),
          SizedBox(height: AppSpacing.lg.h),
          for (var index = 0; index < options.length; index++) ...[
            _OptionTile(
              label: options[index],
              index: index,
              selected: selectedOptionIndex == index,
              colorScheme: colorScheme,
              onTap: isEnabled ? () => onOptionSelected(index) : null,
            ),
            if (index != options.length - 1) SizedBox(height: AppSpacing.sm.h),
          ],
        ],
      ),
    );
  }
}

class _OptionTile extends StatelessWidget {
  const _OptionTile({
    required this.label,
    required this.index,
    required this.selected,
    required this.colorScheme,
    required this.onTap,
  });

  final String label;
  final int index;
  final bool selected;
  final ColorScheme colorScheme;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final background = selected
        ? colorScheme.primaryContainer
        : colorScheme.surfaceContainerHighest.withValues(alpha: 0.45);
    final borderColor =
        selected ? colorScheme.primary : colorScheme.outlineVariant;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.md),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.md.w,
          vertical: AppSpacing.md.h,
        ),
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(color: borderColor, width: selected ? 1.6 : 1),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 12,
              backgroundColor: selected
                  ? colorScheme.primary
                  : colorScheme.primary.withValues(alpha: 0.14),
              child: Text(
                String.fromCharCode(65 + index),
                style: AppTextStyles.labelMedium(
                  selected ? colorScheme.onPrimary : colorScheme.primary,
                ),
              ),
            ),
            SizedBox(width: AppSpacing.sm.w),
            Expanded(
              child: Text(
                label,
                style: AppTextStyles.bodyMedium(colorScheme.onSurface),
              ),
            ),
            if (selected) Icon(Icons.check_circle, color: colorScheme.primary),
          ],
        ),
      ),
    );
  }
}
