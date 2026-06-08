import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_spacing.dart';
import 'input_block.dart';
import 'keyword_wrap.dart';
import 'shared_widgets.dart';
import 'tone_selector.dart';

class PersonalizeCard extends StatelessWidget {
  const PersonalizeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'coverLetter.personalize.title'.tr(),
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: AppColors.neutral900,
                  fontWeight: FontWeight.w900,
                ),
          ),
          SizedBox(height: 4.h),
          Text(
            'coverLetter.personalize.subtitle'.tr(),
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: AppColors.neutral600,
                  height: 1.35,
                  fontWeight: FontWeight.w500,
                ),
          ),
          SizedBox(height: AppSpacing.md.h),
          FieldLabel('coverLetter.personalize.toneOfVoice'.tr()),
          SizedBox(height: AppSpacing.xs.h),
          const ToneSelector(),
          SizedBox(height: AppSpacing.md.h),
          FieldLabel('coverLetter.personalize.focusKeywords'.tr()),
          SizedBox(height: AppSpacing.xs.h),
          const KeywordWrap(),
          SizedBox(height: AppSpacing.md.h),
          InputBlock(
            label: 'coverLetter.personalize.companyInterest'.tr(),
            hint: 'coverLetter.personalize.companyInterestHint'.tr(),
          ),
          SizedBox(height: AppSpacing.md.h),
          InputBlock(
            label: 'coverLetter.personalize.achievement'.tr(),
            hint: 'coverLetter.personalize.achievementHint'.tr(),
          ),
        ],
      ),
    );
  }
}
