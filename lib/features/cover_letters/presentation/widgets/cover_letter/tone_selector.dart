import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_radius.dart';

class ToneSelector extends StatelessWidget {
  const ToneSelector({
    super.key,
    required this.selectedTone,
    required this.onChanged,
  });

  final String selectedTone;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TonePill(
          labelKey: 'coverLetter.tone.professional',
          value: 'professional',
          selected: selectedTone == 'professional',
          onTap: onChanged,
        ),
        SizedBox(width: 6.w),
        TonePill(
          labelKey: 'coverLetter.tone.enthusiastic',
          value: 'enthusiastic',
          selected: selectedTone == 'enthusiastic',
          onTap: onChanged,
        ),
        SizedBox(width: 6.w),
        TonePill(
          labelKey: 'coverLetter.tone.concise',
          value: 'concise',
          selected: selectedTone == 'concise',
          onTap: onChanged,
        ),
      ],
    );
  }
}

class TonePill extends StatelessWidget {
  const TonePill({
    super.key,
    required this.labelKey,
    required this.value,
    required this.onTap,
    this.selected = false,
  });

  final String labelKey;
  final String value;
  final ValueChanged<String> onTap;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final foregroundColor =
        selected ? colorScheme.primary : colorScheme.onSurfaceVariant;
    final backgroundColor = _pillTint(
      context,
      foregroundColor,
      alpha: selected ? .14 : .06,
    );

    return Expanded(
      child: InkWell(
        onTap: () => onTap(value),
        borderRadius: BorderRadius.circular(AppRadius.pill.r),
        child: Container(
          height: 28.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(AppRadius.pill.r),
            border: Border.all(
              color: foregroundColor.withValues(alpha: selected ? .48 : .28),
            ),
          ),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              labelKey.tr(),
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: foregroundColor,
                    fontWeight: FontWeight.w800,
                  ),
            ),
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
