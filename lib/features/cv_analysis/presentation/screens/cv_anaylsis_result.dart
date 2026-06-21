import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/di/di.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../ai_chat/presentation/cubit/chat_cubit.dart';
import '../../domain/entities/cv_anaysis_entity.dart';
import '../cubit/cv_analysis_cubit.dart';
import '../cubit/cv_anaylsis_state.dart';


class CvAnalysisResultScreen extends StatelessWidget {
  final String cvId;

  const CvAnalysisResultScreen({super.key, required this.cvId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<CvAnalysisCubit>()..loadAnalysis(cvId),
      child: const _CvAnalysisResultView(),
    );
  }
}

class _CvAnalysisResultView extends StatelessWidget {
  const _CvAnalysisResultView();

  Future<void> _startChatAboutCv(BuildContext context) async {
    final chatCubit = getIt<ChatCubit>();
    final session = await chatCubit.createSession(title: 'CV Review Chat');
    if (session != null && context.mounted) {
      Navigator.pushNamed(context, AppRoutes.aiChat, arguments: session.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: cs.surface,
      appBar: AppBar(
        backgroundColor: cs.surface,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded,
              size: 18.sp, color: cs.onSurface),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'cvResult.title'.tr(),
          style: AppTextStyles.titleMedium(context as Color),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<CvAnalysisCubit, CvAnalysisState>(
        builder: (context, state) {
          if (state is CvAnalysisInitial ||
              state is CvStatusLoading ||
              state is CvUploadLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is CvAnalyzing) {
            return _buildProcessing(context);
          }

          if (state is CvAnalysisError) {
            return _buildError(context, state.message);
          }

          if (state is CvAnalysisLoaded) {
            return _buildResult(context, state.result);
          }

          // CvStatusLoaded — still uploaded/processing, not analyzed yet
          if (state is CvStatusLoaded) {
            return _buildProcessing(context);
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildProcessing(BuildContext context) {
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
              'cvResult.processing'.tr(),
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyMedium(cs.onSurface),
            ),
            SizedBox(height: AppSpacing.xs.h),
            Text(
              'cvResult.processingHint'.tr(),
              textAlign: TextAlign.center,
              style: AppTextStyles.labelSmall(cs.onSurface.withOpacity(0.5)),
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
              message.tr(),
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyMedium(cs.onSurface),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResult(BuildContext context, CvWithAnalysisEntity result) {
    final cs = Theme.of(context).colorScheme;
    final analysis = result.analysis;

    if (analysis == null) {
      return _buildError(context, 'cvResult.noAnalysis');
    }

    return SingleChildScrollView(
      padding: EdgeInsets.all(AppSpacing.lg.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Score circle
          Center(child: _ScoreCircle(score: analysis.score)),
          SizedBox(height: AppSpacing.lg.h),

          // File name
          Center(
            child: Text(
              result.originalName,
              style: AppTextStyles.bodySmall(cs.onSurface.withOpacity(0.5)),
            ),
          ),
          SizedBox(height: AppSpacing.xl.h),

          // Summary
          _SectionCard(
            icon: Icons.summarize_outlined,
            iconColor: AppColors.primary,
            title: 'cvResult.summary'.tr(),
            child: Text(
              analysis.summary,
              style: AppTextStyles.bodyMedium(cs.onSurface),
            ),
          ),
          SizedBox(height: AppSpacing.md.h),

          // Strengths
          if (analysis.strengths.isNotEmpty)
            _SectionCard(
              icon: Icons.thumb_up_outlined,
              iconColor: AppColors.success,
              title: 'cvResult.strengths'.tr(),
              child: _BulletList(
                items: analysis.strengths,
                color: AppColors.success,
              ),
            ),
          if (analysis.strengths.isNotEmpty) SizedBox(height: AppSpacing.md.h),

          // Weaknesses
          if (analysis.weaknesses.isNotEmpty)
            _SectionCard(
              icon: Icons.report_problem_outlined,
              iconColor: AppColors.warning,
              title: 'cvResult.weaknesses'.tr(),
              child: _BulletList(
                items: analysis.weaknesses,
                color: AppColors.warning,
              ),
            ),
          if (analysis.weaknesses.isNotEmpty)
            SizedBox(height: AppSpacing.md.h),

          // Suggestions
          if (analysis.suggestions.isNotEmpty)
            _SectionCard(
              icon: Icons.lightbulb_outline_rounded,
              iconColor: AppColors.tertiary,
              title: 'cvResult.suggestions'.tr(),
              child: _BulletList(
                items: analysis.suggestions,
                color: AppColors.tertiary,
              ),
            ),

          SizedBox(height: AppSpacing.xl.h),

          // CTA — chat about this CV
          SizedBox(
            width: double.infinity,
            height: 50.h,
            child: ElevatedButton.icon(
              onPressed: () => _startChatAboutCv(context),
              icon: Icon(Icons.smart_toy_rounded, size: 18.sp),
              label: Text(
                'cvResult.chatAboutCv'.tr(),
                style: AppTextStyles.bodyMedium(Colors.white)
                    .copyWith(fontWeight: FontWeight.w700),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadius.md.r),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Score Circle ─────────────────────────────────────────────────────────────

class _ScoreCircle extends StatelessWidget {
  final int score;

  const _ScoreCircle({required this.score});

  Color get _color {
    if (score >= 80) return AppColors.success;
    if (score >= 60) return AppColors.warning;
    return AppColors.error;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 140.w,
      height: 140.w,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: 140.w,
            height: 140.w,
            child: CircularProgressIndicator(
              value: score / 100,
              strokeWidth: 10,
              backgroundColor: _color.withOpacity(0.12),
              valueColor: AlwaysStoppedAnimation(_color),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '$score',
                style: AppTextStyles.titleLarge(context as Color).copyWith(
                  fontSize: 36.sp,
                  fontWeight: FontWeight.w800,
                  color: _color,
                ),
              ),
              Text(
                'cvResult.score'.tr(),
                style: AppTextStyles.labelSmall(_color.withOpacity(0.7)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─── Section Card ─────────────────────────────────────────────────────────────

class _SectionCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final Widget child;

  const _SectionCard({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSpacing.md.w),
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest.withOpacity(0.4),
        borderRadius: BorderRadius.circular(AppRadius.md.r),
        border: Border.all(color: cs.outline.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 18.sp, color: iconColor),
              SizedBox(width: AppSpacing.xs.w),
              Text(
                title,
                style: AppTextStyles.bodyMedium(cs.onSurface)
                    .copyWith(fontWeight: FontWeight.w700),
              ),
            ],
          ),
          SizedBox(height: AppSpacing.sm.h),
          child,
        ],
      ),
    );
  }
}

// ─── Bullet List ──────────────────────────────────────────────────────────────

class _BulletList extends StatelessWidget {
  final List<String> items;
  final Color color;

  const _BulletList({required this.items, required this.color});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items
          .map(
            (item) => Padding(
          padding: EdgeInsets.only(bottom: AppSpacing.xs.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: 7.h, right: 8.w),
                width: 6.w,
                height: 6.w,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
              ),
              Expanded(
                child: Text(
                  item,
                  style: AppTextStyles.bodySmall(cs.onSurface),
                ),
              ),
            ],
          ),
        ),
      )
          .toList(),
    );
  }
}