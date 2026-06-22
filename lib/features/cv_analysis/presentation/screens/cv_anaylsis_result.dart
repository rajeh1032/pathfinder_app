import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../core/di/di.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/cv_analysis_ui_models.dart';
import '../../domain/entities/cv_anaysis_entity.dart';
import '../cubit/cv_anaylsis_state.dart';
import '../cubit/cv_anaysis_cubit.dart';
import '../widgets/ai_insight_card.dart';
import '../widgets/check_list_section.dart' hide AiInsightsCard;
import '../widgets/chips_section.dart';
import '../widgets/recommendation_section.dart';
import '../widgets/score_section.dart';
import '../widgets/upload_cv_button.dart';

class CvAnalysisResult extends StatelessWidget {
  final String? cvId;
  final String? filePath;


  const CvAnalysisResult({super.key, this.cvId, this.filePath});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final cubit = getIt<CvAnalysisCubit>();
        if (filePath != null) {
          cubit.uploadAndAnalyze(filePath!);
        } else if (cvId != null) {
          cubit.loadAnalysis(cvId!);
        } else {
          cubit.loadLatestAnalysis();
        }
        return cubit;
      },
      child: const _CvAnalysisResultView(),
    );
  }
}

class _CvAnalysisResultView extends StatelessWidget {
  const _CvAnalysisResultView();

  Future<void> _onUploadNewCv(BuildContext context) async {
    final cubit = context.read<CvAnalysisCubit>();
    await cubit.pickAndUpload();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

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
      body: BlocBuilder<CvAnalysisCubit, CvAnalysisState>(
        builder: (context, state) {
          if (state is CvAnalysisInitial || state is CvStatusLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is CvUploadLoading) {
            return _buildUploading(context, state.progress);
          }

          if (state is CvAnalyzing) {
            return _buildAnalyzing(context);
          }

          if (state is CvAnalysisError) {
            return _buildError(context, state.message);
          }

          if (state is CvAnalysisLoaded) {
            return _buildResult(context, state.result);
          }

          // CvStatusLoaded: user has no analyzed CV yet — show upload CTA.
          if (state is CvStatusLoaded && !state.status.hasCv) {
            return _buildNoCv(context);
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildUploading(BuildContext context, double progress) {
    final cs = Theme.of(context).colorScheme;
    return Center(
      child: Padding(
        padding: EdgeInsets.all(AppSpacing.lg.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(
              value: progress,
              color: AppColors.primary,
            ),
            SizedBox(height: AppSpacing.md.h),
            Text(
              'cvAnalysis.uploading'.tr(),
              style: AppTextStyles.bodyMedium(cs.onSurface),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnalyzing(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Center(
      child: Padding(
        padding: EdgeInsets.all(AppSpacing.lg.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(color: AppColors.primary),
            SizedBox(height: AppSpacing.lg.h),
            Text(
              'cvAnalysis.analyzing'.tr(),
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyMedium(cs.onSurface),
            ),
            SizedBox(height: AppSpacing.xs.h),
            Text(
              'cvAnalysis.analyzingHint'.tr(),
              textAlign: TextAlign.center,
              style: AppTextStyles.labelSmall(cs.onSurface.withOpacity(0.5)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNoCv(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Center(
      child: Padding(
        padding: EdgeInsets.all(AppSpacing.lg.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.description_outlined,
                size: 56.sp, color: cs.onSurface.withOpacity(0.25)),
            SizedBox(height: AppSpacing.md.h),
            Text(
              'cvAnalysis.noCvYet'.tr(),
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyMedium(cs.onSurface),
            ),
            SizedBox(height: AppSpacing.lg.h),
            UploadCvButton(
              onPressed: () => _onUploadNewCv(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildError(BuildContext context, String message) {
    final cs = Theme.of(context).colorScheme;
    return Center(
      child: Padding(
        padding: EdgeInsets.all(AppSpacing.lg.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline_rounded,
                size: 48.sp, color: AppColors.error),
            SizedBox(height: AppSpacing.md.h),
            Text(
              message,
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyMedium(cs.onSurface),
            ),
            SizedBox(height: AppSpacing.lg.h),
            UploadCvButton(
              onPressed: () => _onUploadNewCv(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResult(BuildContext context, CvWithAnalysisEntity result) {
    final analysis = result.analysis;

    if (analysis == null) {
      return _buildError(context, 'cvAnalysis.noAnalysisAvailable'.tr());
    }

    final strengthChips = CvSkillChip.strengthsFrom(analysis.strengths);
    final weaknessChips = CvSkillChip.weaknessesFrom(analysis.weaknesses);
    final missingChips = CvSkillChip.missingFrom(analysis.suggestions);
    final recommendations =
    CvRecommendation.fromSuggestions(analysis.suggestions);

    final analyzedTime = DateFormat('MMM d, y · h:mm a')
        .format(result.cv.uploadedAt.toLocal());

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.md.w,
        vertical: AppSpacing.md.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Score Circle
          ScoreSection(
            score: analysis.score,
            analyzedRole: '', // backend doesn't return a target role here
            analyzedTime: analyzedTime,
          ),
          SizedBox(height: AppSpacing.lg.h),

          // AI Insights — uses the analysis summary as the insight text
          AiInsightsCard(insight: analysis.summary),
          SizedBox(height: AppSpacing.lg.h),

          // Strengths
          if (strengthChips.isNotEmpty) ...[
            ChipsSection(
              title: 'cvAnalysis.strengths'.tr(),
              icon: Icons.check_circle_outline_rounded,
              iconColor: AppColors.success,
              chips: strengthChips,
            ),
            SizedBox(height: AppSpacing.lg.h),
          ],

          // Weaknesses
          if (weaknessChips.isNotEmpty) ...[
            ChipsSection(
              title: 'cvAnalysis.weaknesses'.tr(),
              icon: Icons.warning_amber_rounded,
              iconColor: AppColors.warning,
              chips: weaknessChips,
            ),
            SizedBox(height: AppSpacing.lg.h),
          ],

          // Missing skills (derived from suggestions)
          if (missingChips.isNotEmpty) ...[
            ChipsSection(
              title: 'cvAnalysis.missingSkills'.tr(),
              icon: Icons.highlight_off_rounded,
              iconColor: AppColors.error,
              chips: missingChips,
            ),
            SizedBox(height: AppSpacing.lg.h),
          ],

          ChecklistSection(items: analysis.suggestions),
          SizedBox(height: AppSpacing.lg.h),

          // AI Recommendations
          RecommendationsSection(recommendations: recommendations),
          SizedBox(height: AppSpacing.lg.h),

          // Upload New CV button
          UploadCvButton(onPressed: () => _onUploadNewCv(context)),
          SizedBox(height: AppSpacing.xl.h),
        ],
      ),
    );
  }
}