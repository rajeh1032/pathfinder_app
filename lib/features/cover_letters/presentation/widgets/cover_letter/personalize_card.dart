import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_spacing.dart';
import 'input_block.dart';
import 'keyword_wrap.dart';
import 'shared_widgets.dart';
import 'tone_selector.dart';

class PersonalizeCard extends StatelessWidget {
  const PersonalizeCard({
    super.key,
    required this.selectedTone,
    required this.selectedKeywords,
    required this.companyInterestController,
    required this.achievementController,
    required this.availableKeywords,
    required this.onToneChanged,
    required this.onKeywordToggled,
  });

  final String selectedTone;
  final Set<String> selectedKeywords;
  final TextEditingController companyInterestController;
  final TextEditingController achievementController;
  final List<String> availableKeywords;
  final ValueChanged<String> onToneChanged;
  final ValueChanged<String> onKeywordToggled;

  @override
  Widget build(BuildContext context) {
    return SurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'coverLetter.personalize.title'.tr(),
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.w900,
                ),
          ),
          SizedBox(height: 4.h),
          Text(
            'coverLetter.personalize.subtitle'.tr(),
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  height: 1.35,
                  fontWeight: FontWeight.w500,
                ),
          ),
          SizedBox(height: AppSpacing.md.h),
          FieldLabel('coverLetter.personalize.toneOfVoice'.tr()),
          SizedBox(height: AppSpacing.xs.h),
          ToneSelector(
            selectedTone: selectedTone,
            onChanged: onToneChanged,
          ),
          SizedBox(height: AppSpacing.md.h),
          FieldLabel('coverLetter.personalize.focusKeywords'.tr()),
          SizedBox(height: AppSpacing.xs.h),
          KeywordWrap(
            selectedKeywords: selectedKeywords,
            keywords: availableKeywords,
            onToggle: onKeywordToggled,
          ),
          SizedBox(height: AppSpacing.md.h),
          InputBlock(
            label: 'coverLetter.personalize.companyInterest'.tr(),
            hint: 'coverLetter.personalize.companyInterestHint'.tr(),
            controller: companyInterestController,
          ),
          SizedBox(height: AppSpacing.md.h),
          InputBlock(
            label: 'coverLetter.personalize.achievement'.tr(),
            hint: 'coverLetter.personalize.achievementHint'.tr(),
            controller: achievementController,
          ),
        ],
      ),
    );
  }
}
