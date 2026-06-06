import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_radius.dart';

class KeywordWrap extends StatelessWidget {
  const KeywordWrap({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 6.w,
      runSpacing: 6.h,
      children: const [
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
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: outlined ? Colors.white : AppColors.primarySoft,
        borderRadius: BorderRadius.circular(AppRadius.pill.r),
        border: Border.all(color: AppColors.primaryContainer),
      ),
      child: Text(
        labelKey.tr(),
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: AppColors.primaryDark,
              fontWeight: FontWeight.w800,
            ),
      ),
    );
  }
}
