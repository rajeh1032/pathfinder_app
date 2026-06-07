
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../cv_anaylsis_dummy_model.dart';
import '../widgets/ai_insight_card.dart';
import '../widgets/check_list_section.dart';
import '../widgets/chips_section.dart';
import '../widgets/recommendation_section.dart';
import '../widgets/score_section.dart';
import '../widgets/upload_cv_button.dart';

  class CvAnalysisResult extends StatelessWidget {
  const CvAnalysisResult({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, size: 20.sp),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'PathFinder AI',
          style: AppTextStyles.titleMedium(AppColors.primary).copyWith(
            fontSize: 18.sp,
            fontWeight: FontWeight.w800,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.md.w,
          vertical: AppSpacing.md.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Score Circle
            ScoreSection(),
            SizedBox(height: AppSpacing.lg.h),
            // AI Insights
            AiInsightsCard(),
            SizedBox(height: AppSpacing.lg.h),
            // Strengths
            ChipsSection(
              title: 'Strengths',
              icon: Icons.check_circle_outline_rounded,
              iconColor: AppColors.success,
              chips: CvAnalysisDummyData.strengths,
            ),
            SizedBox(height: AppSpacing.lg.h),
            // Weaknesses
            ChipsSection(
              title: 'Weaknesses',
              icon: Icons.warning_amber_rounded,
              iconColor: AppColors.warning,
              chips: CvAnalysisDummyData.weaknesses,
            ),
            SizedBox(height: AppSpacing.lg.h),
            // Missing Skills
            ChipsSection(
              title: 'Missing Skills',
              icon: Icons.highlight_off_rounded,
              iconColor: AppColors.error,
              chips: CvAnalysisDummyData.missingSkills,
            ),
            SizedBox(height: AppSpacing.lg.h),
            // Improvement Checklist
            ChecklistSection(),
            SizedBox(height: AppSpacing.lg.h),
            // AI Recommendations
            RecommendationsSection(),
            SizedBox(height: AppSpacing.lg.h),
            // Upload New CV button
            UploadCvButton(),
            SizedBox(height: AppSpacing.xl.h),
          ],
        ),
      ),
    );
  }
}





