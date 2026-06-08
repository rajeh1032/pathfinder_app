import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_radius.dart';

class ToneSelector extends StatelessWidget {
  const ToneSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const TonePill(
            labelKey: 'coverLetter.tone.professional', selected: true),
        SizedBox(width: 6.w),
        const TonePill(labelKey: 'coverLetter.tone.enthusiastic'),
        SizedBox(width: 6.w),
        const TonePill(labelKey: 'coverLetter.tone.concise'),
      ],
    );
  }
}

class TonePill extends StatelessWidget {
  const TonePill({super.key, required this.labelKey, this.selected = false});

  final String labelKey;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 28.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? AppColors.primaryDark : AppColors.lightSurface,
          borderRadius: BorderRadius.circular(AppRadius.sm.r),
          border: Border.all(
            color: selected ? AppColors.primaryDark : AppColors.lightBorder,
          ),
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            labelKey.tr(),
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: selected ? Colors.white : AppColors.neutral600,
                  fontWeight: FontWeight.w800,
                ),
          ),
        ),
      ),
    );
  }
}
