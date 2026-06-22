import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../domain/entities/cv_analysis_ui_models.dart';
import '../../domain/entities/cv_anaysis_entity.dart';
import 'ai_insight_card.dart';
import 'check_list_section.dart';
import 'chips_section.dart';
import 'recommendation_section.dart';
import 'score_section.dart';
import 'upload_cv_button.dart';

class CvAnalysisResultContent extends StatelessWidget {
  const CvAnalysisResultContent({
    super.key,
    required this.result,
    required this.onUploadNewCv,
  });

  final CvWithAnalysisEntity result;
  final VoidCallback onUploadNewCv;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final analysis = result.analysis;
    final roles = analysis.extracted.recommendedRoles;

    return SingleChildScrollView(
      padding: EdgeInsets.all(AppSpacing.md.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ScoreSection(
            score: analysis.score,
            analyzedRole: roles.isEmpty ? '' : roles.first,
            analyzedTime: DateFormat.yMMMd().add_jm().format(
                  result.cv.uploadedAt.toLocal(),
                ),
          ),
          SizedBox(height: AppSpacing.lg.h),
          AiInsightsCard(insight: analysis.summary),
          SizedBox(height: AppSpacing.lg.h),
          _chips(context, 'cvAnalysis.strengths', Icons.check_circle_outline,
              colors.secondary, analysis.strengths, SkillChipType.strength),
          _chips(context, 'cvAnalysis.weaknesses', Icons.warning_amber_rounded,
              colors.tertiary, analysis.weaknesses, SkillChipType.weakness),
          _chips(
              context,
              'cvAnalysis.missingSkills',
              Icons.highlight_off,
              colors.error,
              analysis.extracted.missingSkills,
              SkillChipType.missing),
          ChecklistSection(items: analysis.suggestions),
          SizedBox(height: AppSpacing.lg.h),
          RecommendationsSection(
            recommendations: CvRecommendation.fromSuggestions(
              analysis.suggestions,
            ),
          ),
          SizedBox(height: AppSpacing.lg.h),
          UploadCvButton(onPressed: onUploadNewCv),
          SizedBox(height: AppSpacing.xl.h),
        ],
      ),
    );
  }

  Widget _chips(
    BuildContext context,
    String titleKey,
    IconData icon,
    Color color,
    List<String> labels,
    SkillChipType type,
  ) {
    if (labels.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: EdgeInsets.only(bottom: AppSpacing.lg.h),
      child: ChipsSection(
        title: titleKey.tr(),
        icon: icon,
        iconColor: color,
        chips: labels
            .map((label) => CvSkillChip(label: label, type: type))
            .toList(),
      ),
    );
  }
}
