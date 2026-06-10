import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../widgets/interview_history_filter_bar.dart';
import '../widgets/interview_history_session_card.dart';
import '../widgets/interview_history_search_field.dart';
import '../widgets/interview_history_stats_card.dart';

class InterviewHistoryScreen extends StatefulWidget {
  const InterviewHistoryScreen({super.key});

  @override
  State<InterviewHistoryScreen> createState() => _InterviewHistoryScreenState();
}

class _InterviewHistoryScreenState extends State<InterviewHistoryScreen> {
  int _selectedFilterIndex = 0;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        toolbarHeight: 76.h,
        titleSpacing: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'interview.historyTitle'.tr(),
              style: AppTextStyles.titleLarge(colorScheme.onSurface),
            ),
            Text(
              'interview.historySubtitle'.tr(),
              style: AppTextStyles.bodySmall(colorScheme.onSurfaceVariant),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search_rounded),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.tune_rounded),
          ),
        ],
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final contentWidth = constraints.maxWidth > 720
                ? 720.0
                : constraints.maxWidth;

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
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const InterviewHistoryStatsCard(),
                      SizedBox(height: AppSpacing.lg.h),
                      const InterviewHistorySearchField(),
                      SizedBox(height: AppSpacing.md.h),
                      InterviewHistoryFilterBar(
                        selectedIndex: _selectedFilterIndex,
                        onChanged: (index) {
                          setState(() => _selectedFilterIndex = index);
                        },
                      ),
                      SizedBox(height: AppSpacing.lg.h),
                      const InterviewHistorySessionCard(
                        accentColorIndex: 0,
                        typeKey: 'interview.technicalInterview',
                        titleKey: 'interview.frontendDeveloper',
                        completedDateKey: 'interview.completedOn',
                        questionsKey: 'interview.questionsCount',
                        minutesKey: 'interview.minutesCount',
                        score: 82,
                        insightTitleKey: 'interview.quickInsightLabel',
                        insightDescriptionKey: 'interview.strongReactKnowledge',
                      ),
                      SizedBox(height: AppSpacing.md.h),
                      const InterviewHistorySessionCard(
                        accentColorIndex: 1,
                        typeKey: 'interview.behavioralInterview',
                        titleKey: 'interview.seniorUiUxDesigner',
                        completedDateKey: 'interview.completedOn',
                        questionsKey: 'interview.questionsCount',
                        minutesKey: 'interview.minutesCount',
                        score: 88,
                        insightTitleKey: 'interview.quickInsightLabel',
                        insightDescriptionKey:
                            'interview.improveStarMethodResponses',
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
