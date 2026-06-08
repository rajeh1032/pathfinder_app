import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_radius.dart';

class KeywordWrap extends StatelessWidget {
  const KeywordWrap({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 6.w,
      runSpacing: 6.h,
      children: [
        KeywordChip(labelKey: 'coverLetter.keywords.leadership'),
        KeywordChip(labelKey: 'coverLetter.keywords.reactNative'),
        KeywordChip(labelKey: 'coverLetter.keywords.uiDesign'),
        KeywordChip(labelKey: 'coverLetter.keywords.addSkill', outlined: true),
      ],
    );
  }
}

class KeywordChip extends StatelessWidget {
  const KeywordChip({super.key, required this.labelKey, this.outlined = false});

  final String labelKey;
  final bool outlined;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final backgroundColor = _pillTint(
      context,
      colorScheme.primary,
      alpha: outlined ? .04 : .12,
    );
    final foregroundColor = colorScheme.primary;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 7.h),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(AppRadius.pill.r),
        border: Border.all(
          color: colorScheme.primary.withValues(alpha: .42),
        ),
      ),
      child: Text(
        labelKey.tr(),
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: foregroundColor,
              fontWeight: FontWeight.w800,
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
