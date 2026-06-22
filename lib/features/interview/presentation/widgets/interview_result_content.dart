import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/routing/app_routes.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_button.dart';
import '../../domain/entities/interview_result.dart';
import '../../domain/entities/interview_result_session.dart';
import 'interview_result_callout_card.dart';
import 'interview_result_insight_card.dart';
import 'interview_result_next_step_card.dart';
import 'interview_result_question_tile.dart';
import 'interview_result_summary_card.dart';
import 'interview_result_title_header.dart';
import 'interview_section_header.dart';
import 'interview_skills_grid.dart';

class InterviewResultContent extends StatelessWidget {
  const InterviewResultContent({required this.result, super.key});

  final InterviewResult result;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final session = result.session;
    final comparison = result.comparison;

    return LayoutBuilder(
      builder: (context, constraints) {
        final contentWidth =
            constraints.maxWidth > 720 ? 720.0 : constraints.maxWidth;
        final isWide = constraints.maxWidth >= 640;

        return SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(
            AppSpacing.md.w,
            AppSpacing.sm.h,
            AppSpacing.md.w,
            AppSpacing.lg.h,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: contentWidth),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InterviewResultTitleHeader(
                    colorScheme: colorScheme,
                    title: session.careerPathTitle ??
                        'interview.assessmentResults'.tr(),
                    interviewType: session.interviewType,
                    durationMinutes: session.durationMinutes,
                    completedAt: session.completedAt,
                  ),
                  SizedBox(height: AppSpacing.md.h),
                  InterviewResultSummaryCard(
                    colorScheme: colorScheme,
                    score: (session.overallScore ?? comparison.currentScore)
                        .round(),
                    previousScore: comparison.previousScore?.round(),
                    improvement: comparison.scoreChange?.round(),
                  ),
                  if (session.quickAiInsight != null &&
                      session.quickAiInsight!.isNotEmpty) ...[
                    SizedBox(height: AppSpacing.md.h),
                    InterviewResultCalloutCard(
                      colorScheme: colorScheme,
                      title: 'interview.quickInsightLabel'.tr(),
                      description: session.quickAiInsight!,
                    ),
                  ],
                  if (result.skillsBreakdown.isNotEmpty) ...[
                    SizedBox(height: AppSpacing.xl.h),
                    const InterviewSectionHeader(
                      titleKey: 'interview.skillsBreakdown',
                    ),
                    SizedBox(height: AppSpacing.sm.h),
                    InterviewSkillsGrid(skills: result.skillsBreakdown),
                  ],
                  _buildInsights(context, colorScheme, isWide, session),
                  _buildNextSteps(context, session),
                  _buildQuestionBreakdown(context),
                  SizedBox(height: AppSpacing.lg.h),
                  _buildActions(context, isWide),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildInsights(
    BuildContext context,
    ColorScheme colorScheme,
    bool isWide,
    InterviewResultSession session,
  ) {
    final hasStrengths = session.strengths.isNotEmpty;
    final hasAreas = session.areasForImprovement.isNotEmpty;
    if (!hasStrengths && !hasAreas) return const SizedBox.shrink();

    final strengthsCard = InterviewResultInsightCard(
      color: colorScheme.secondaryContainer,
      icon: Icons.thumb_up_alt_rounded,
      iconColor: colorScheme.secondary,
      titleKey: 'interview.strengths',
      items: session.strengths,
    );
    final areasCard = InterviewResultInsightCard(
      color: colorScheme.tertiaryContainer,
      icon: Icons.report_problem_rounded,
      iconColor: colorScheme.tertiary,
      titleKey: 'interview.areasForImprovement',
      items: session.areasForImprovement,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: AppSpacing.xl.h),
        if (isWide && hasStrengths && hasAreas)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: strengthsCard),
              SizedBox(width: AppSpacing.md.w),
              Expanded(child: areasCard),
            ],
          )
        else ...[
          if (hasStrengths) strengthsCard,
          if (hasStrengths && hasAreas) SizedBox(height: AppSpacing.md.h),
          if (hasAreas) areasCard,
        ],
      ],
    );
  }

  Widget _buildNextSteps(BuildContext context, InterviewResultSession session) {
    final recommendations = session.recommendations;
    if (recommendations.isEmpty) return const SizedBox.shrink();

    const icons = [
      Icons.menu_book_rounded,
      Icons.auto_fix_high_rounded,
      Icons.lightbulb_rounded,
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: AppSpacing.xl.h),
        const InterviewSectionHeader(
          titleKey: 'interview.recommendedNextSteps',
        ),
        SizedBox(height: AppSpacing.sm.h),
        SizedBox(
          height: 92.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: recommendations.length,
            separatorBuilder: (_, __) => SizedBox(width: AppSpacing.sm.w),
            itemBuilder: (context, index) {
              return InterviewResultNextStepCard(
                icon: icons[index % icons.length],
                title: 'interview.recommendationLabel'.tr(
                  namedArgs: {'number': '${index + 1}'},
                ),
                subtitle: recommendations[index],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildQuestionBreakdown(BuildContext context) {
    final questions = result.questionBreakdown;
    if (questions.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: AppSpacing.xl.h),
        const InterviewSectionHeader(
          titleKey: 'interview.questionBreakdown',
        ),
        SizedBox(height: AppSpacing.sm.h),
        for (var index = 0; index < questions.length; index++) ...[
          InterviewResultQuestionTile(
            question: questions[index],
            expanded: index == 0,
          ),
          if (index != questions.length - 1)
            SizedBox(height: AppSpacing.sm.h),
        ],
      ],
    );
  }

  Widget _buildActions(BuildContext context, bool isWide) {
    final retryButton = AppButton(
      label: 'interview.retry'.tr(),
      onPressed: () {
        Navigator.of(context).pushReplacementNamed(AppRoutes.interviewStart);
      },
    );
    final homeButton = AppButton(
      label: 'interview.returnHome'.tr(),
      onPressed: () {
        Navigator.of(context).pushNamedAndRemoveUntil(
          AppRoutes.root,
          (route) => false,
        );
      },
    );

    if (isWide) {
      return Row(
        children: [
          Expanded(child: retryButton),
          SizedBox(width: AppSpacing.md.w),
          Expanded(child: homeButton),
        ],
      );
    }

    return Column(
      children: [
        SizedBox(width: double.infinity, child: retryButton),
        SizedBox(height: AppSpacing.sm.h),
        SizedBox(width: double.infinity, child: homeButton),
      ],
    );
  }
}
