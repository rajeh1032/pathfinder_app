import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/routing/app_routes.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_button.dart';
import '../widgets/interview_result_callout_card.dart';
import '../widgets/interview_result_insight_card.dart';
import '../widgets/interview_result_next_step_card.dart';
import '../widgets/interview_result_question_tile.dart';
import '../widgets/interview_result_summary_card.dart';
import '../widgets/interview_result_title_header.dart';
import '../widgets/interview_skills_grid.dart';
import '../widgets/interview_section_header.dart';

class InterviewResultScreen extends StatelessWidget {
  const InterviewResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        centerTitle: true,
        title: Text('interview.assessmentResults'.tr()),
      ),
      body: SafeArea(
        child: LayoutBuilder(
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
                      InterviewResultTitleHeader(colorScheme: colorScheme),
                      SizedBox(height: AppSpacing.md.h),
                      InterviewResultSummaryCard(colorScheme: colorScheme),
                      SizedBox(height: AppSpacing.xl.h),
                      const InterviewSectionHeader(
                        titleKey: 'interview.skillsBreakdown',
                      ),
                      SizedBox(height: AppSpacing.sm.h),
                      const InterviewSkillsGrid(),
                      SizedBox(height: AppSpacing.xl.h),
                      if (isWide)
                        Row(
                          children: [
                            Expanded(
                              child: InterviewResultInsightCard(
                                color: colorScheme.secondaryContainer,
                                icon: Icons.thumb_up_alt_rounded,
                                iconColor: colorScheme.secondary,
                                titleKey: 'interview.strengths',
                                items: const [
                                  'interview.reactArchitecture',
                                  'interview.technicalKnowledge',
                                ],
                              ),
                            ),
                            SizedBox(width: AppSpacing.md.w),
                            Expanded(
                              child: InterviewResultInsightCard(
                                color: colorScheme.tertiaryContainer,
                                icon: Icons.report_problem_rounded,
                                iconColor: colorScheme.tertiary,
                                titleKey: 'interview.areasForImprovement',
                                items: const [
                                  'interview.starMethod',
                                  'interview.commStructure',
                                ],
                              ),
                            ),
                          ],
                        )
                      else ...[
                        InterviewResultInsightCard(
                          color: colorScheme.secondaryContainer,
                          icon: Icons.thumb_up_alt_rounded,
                          iconColor: colorScheme.secondary,
                          titleKey: 'interview.strengths',
                          items: const [
                            'interview.reactArchitecture',
                            'interview.technicalKnowledge',
                          ],
                        ),
                        SizedBox(height: AppSpacing.md.h),
                        InterviewResultInsightCard(
                          color: colorScheme.tertiaryContainer,
                          icon: Icons.report_problem_rounded,
                          iconColor: colorScheme.tertiary,
                          titleKey: 'interview.areasForImprovement',
                          items: const [
                            'interview.starMethod',
                            'interview.commStructure',
                          ],
                        ),
                      ],
                      SizedBox(height: AppSpacing.lg.h),
                      InterviewResultCalloutCard(
                        colorScheme: colorScheme,
                        titleKey: 'interview.practiceWeakQuestionsAgain',
                        descriptionKey:
                            'interview.practiceWeakQuestionsAgainDescription',
                      ),
                      SizedBox(height: AppSpacing.xl.h),
                      const InterviewSectionHeader(
                        titleKey: 'interview.recommendedNextSteps',
                      ),
                      SizedBox(height: AppSpacing.sm.h),
                      SizedBox(
                        height: 92.h,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return InterviewResultNextStepCard(
                              icon: index == 0
                                  ? Icons.menu_book_rounded
                                  : Icons.auto_fix_high_rounded,
                              titleKey: index == 0
                                  ? 'interview.learnStarMethod'
                                  : 'interview.retakeInterview',
                              subtitleKey: index == 0
                                  ? 'interview.learnStarMethodDescription'
                                  : 'interview.retakeInterviewDescription',
                            );
                          },
                          separatorBuilder: (_, __) =>
                              SizedBox(width: AppSpacing.sm.w),
                          itemCount: 2,
                        ),
                      ),
                      SizedBox(height: AppSpacing.xl.h),
                      const InterviewSectionHeader(
                        titleKey: 'interview.questionBreakdown',
                      ),
                      SizedBox(height: AppSpacing.sm.h),
                      const InterviewResultQuestionTile(
                        titleKey: 'interview.questionTitle',
                        titleArgs: {'number': '1'},
                        score: '65%',
                        statusKey: 'interview.needsImprovement',
                        feedbackKey: 'interview.reactFeedback',
                        suggestionKey: 'interview.reviewReactDocs',
                        expanded: true,
                      ),
                      SizedBox(height: AppSpacing.sm.h),
                      const InterviewResultQuestionTile(
                        titleKey: 'interview.questionPlaceholder',
                      ),
                      SizedBox(height: AppSpacing.sm.h),
                      const InterviewResultQuestionTile(
                        titleKey: 'interview.questionPlaceholder',
                      ),
                      SizedBox(height: AppSpacing.lg.h),
                      isWide
                          ? Row(
                              children: [
                                Expanded(
                                  child: AppButton(
                                    label: 'interview.retry'.tr(),
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushReplacementNamed(
                                        AppRoutes.activeInterview,
                                      );
                                    },
                                  ),
                                ),
                                SizedBox(width: AppSpacing.md.w),
                                Expanded(
                                  child: AppButton(
                                    label: 'interview.returnHome'.tr(),
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushNamedAndRemoveUntil(
                                        AppRoutes.root,
                                        (route) => false,
                                      );
                                    },
                                  ),
                                ),
                              ],
                            )
                          : Column(
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  child: AppButton(
                                    label: 'interview.retry'.tr(),
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushReplacementNamed(
                                        AppRoutes.activeInterview,
                                      );
                                    },
                                  ),
                                ),
                                SizedBox(height: AppSpacing.sm.h),
                                SizedBox(
                                  width: double.infinity,
                                  child: AppButton(
                                    label: 'interview.returnHome'.tr(),
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushNamedAndRemoveUntil(
                                        AppRoutes.root,
                                        (route) => false,
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
