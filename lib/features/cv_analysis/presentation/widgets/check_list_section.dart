import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

/// Simple checklist line item. `isDone` is local UI state — the backend
/// only provides the suggestion text; ticking it off is a client-side
/// "I did this" toggle and is not persisted.
class CvChecklistItem {
  final String text;
  final bool isDone;

  const CvChecklistItem({required this.text, this.isDone = false});
}

class ChecklistSection extends StatefulWidget {
  /// Plain suggestion strings coming from the real analysis result
  /// (e.g. result.analysis.suggestions).
  final List<String> items;

  const ChecklistSection({super.key, required this.items});

  @override
  State<ChecklistSection> createState() => _ChecklistSectionState();
}

class _ChecklistSectionState extends State<ChecklistSection> {
  late List<CvChecklistItem> _items;

  @override
  void initState() {
    super.initState();
    _items = widget.items
        .map((text) => CvChecklistItem(text: text))
        .toList();
  }

  @override
  void didUpdateWidget(covariant ChecklistSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.items != widget.items) {
      _items = widget.items.map((text) => CvChecklistItem(text: text)).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    if (_items.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'cvAnalysis.improvementChecklist'.tr(),
          style: AppTextStyles.titleSmall(colorScheme.onSurface)
              .copyWith(fontSize: 15.sp),
        ),
        SizedBox(height: AppSpacing.sm.h),
        Container(
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(AppRadius.lg.r),
            border: Border.all(color: colorScheme.outline.withValues(alpha: 0.4)),
          ),
          child: Column(
            children: _items.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              final isLast = index == _items.length - 1;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    _items[index] = CvChecklistItem(
                      text: item.text,
                      isDone: !item.isDone,
                    );
                  });
                },
                child: Container(
                  padding: EdgeInsets.all(AppSpacing.md.w),
                  decoration: BoxDecoration(
                    border: isLast
                        ? null
                        : Border(
                      bottom: BorderSide(
                        color: colorScheme.outline.withValues(alpha: 0.3),
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: 20.w,
                        height: 20.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: item.isDone
                                ? AppColors.success
                                : colorScheme.outline,
                            width: 1.5,
                          ),
                          color: item.isDone
                              ? AppColors.success
                              : Colors.transparent,
                        ),
                        child: item.isDone
                            ? Icon(Icons.check, size: 12.sp, color: Colors.white)
                            : null,
                      ),
                      SizedBox(width: AppSpacing.sm.w),
                      Expanded(
                        child: Text(
                          item.text,
                          style: AppTextStyles.bodyMedium(
                            item.isDone
                                ? colorScheme.onSurfaceVariant
                                : colorScheme.onSurface,
                          ).copyWith(
                            fontSize: 13.sp,
                            decoration: item.isDone
                                ? TextDecoration.lineThrough
                                : null,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}