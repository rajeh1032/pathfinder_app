import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_radius.dart';

class KeywordWrap extends StatelessWidget {
  const KeywordWrap({
    super.key,
    required this.selectedKeywords,
    required this.keywords,
    required this.onToggle,
  });

  final Set<String> selectedKeywords;
  final List<String> keywords;
  final ValueChanged<String> onToggle;

  @override
  Widget build(BuildContext context) {
    if (keywords.isEmpty) {
      return Text(
        'No job keywords available.',
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w600,
            ),
      );
    }

    return Wrap(
      spacing: 6.w,
      runSpacing: 6.h,
      children: [
        for (final keyword in keywords)
          KeywordChip(
            label: keyword,
            selected: selectedKeywords.contains(keyword),
            onTap: () => onToggle(keyword),
          ),
      ],
    );
  }
}

class KeywordChip extends StatelessWidget {
  const KeywordChip({
    super.key,
    required this.label,
    required this.onTap,
    this.selected = false,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final backgroundColor = _pillTint(
      context,
      colorScheme.primary,
      alpha: selected ? .16 : .04,
    );
    final foregroundColor =
        selected ? colorScheme.primary : colorScheme.onSurfaceVariant;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.pill.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 7.h),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(AppRadius.pill.r),
          border: Border.all(
            color: colorScheme.primary.withValues(alpha: selected ? .52 : .28),
          ),
        ),
        child: Text(
          label,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: foregroundColor,
                fontWeight: FontWeight.w800,
              ),
        ),
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
