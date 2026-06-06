import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/routing/app_routes.dart';
import '../widgets/interview_result_insight_widgets.dart';
import '../widgets/interview_result_overview_widgets.dart';
import '../widgets/interview_result_question_widgets.dart';
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InterviewResultTitleHeader(colorScheme: colorScheme),
              const SizedBox(height: 18),
              InterviewResultSummaryCard(colorScheme: colorScheme),
              const SizedBox(height: 28),
              const InterviewSectionHeader(titleKey: 'interview.skillsBreakdown'),
              const SizedBox(height: 14),
              const InterviewSkillsGrid(),
              const SizedBox(height: 28),
              Row(
                children: [
                  Expanded(
                    child: InterviewResultInsightCard(
                      color: const Color(0xFFEAF8EF),
                      icon: Icons.thumb_up_alt_rounded,
                      iconColor: const Color(0xFF0F9D58),
                      titleKey: 'interview.strengths',
                      items: const [
                        'interview.reactArchitecture',
                        'interview.technicalKnowledge',
                      ],
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: InterviewResultInsightCard(
                      color: const Color(0xFFFFF4DB),
                      icon: Icons.report_problem_rounded,
                      iconColor: const Color(0xFFF59E0B),
                      titleKey: 'interview.areasForImprovement',
                      items: const [
                        'interview.starMethod',
                        'interview.commStructure',
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              InterviewResultCalloutCard(
                colorScheme: colorScheme,
                titleKey: 'interview.practiceWeakQuestionsAgain',
                descriptionKey:
                    'interview.practiceWeakQuestionsAgainDescription',
              ),
              const SizedBox(height: 28),
              const InterviewSectionHeader(
                titleKey: 'interview.recommendedNextSteps',
              ),
              const SizedBox(height: 14),
              SizedBox(
                height: 92,
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
                  separatorBuilder: (_, __) => const SizedBox(width: 14),
                  itemCount: 2,
                ),
              ),
              const SizedBox(height: 28),
              const InterviewSectionHeader(titleKey: 'interview.questionBreakdown'),
              const SizedBox(height: 14),
              const InterviewResultQuestionTile(
                titleKey: 'interview.questionTitle',
                titleArgs: {'number': '1'},
                score: '65%',
                statusKey: 'interview.needsImprovement',
                feedbackKey: 'interview.reactFeedback',
                suggestionKey: 'interview.reviewReactDocs',
                expanded: true,
              ),
              const SizedBox(height: 12),
              const InterviewResultQuestionTile(
                titleKey: 'interview.questionPlaceholder',
              ),
              const SizedBox(height: 12),
              const InterviewResultQuestionTile(
                titleKey: 'interview.questionPlaceholder',
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacementNamed(
                          AppRoutes.activeInterview,
                        );
                      },
                      child: Text('interview.retry'.tr()),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: FilledButton(
                      onPressed: () {
                        Navigator.of(context).popUntil((route) => route.isFirst);
                      },
                      child: Text('interview.returnHome'.tr()),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
