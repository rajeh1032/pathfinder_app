import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/routing/app_routes.dart';
import '../widgets/interview_section_header.dart';
import '../widgets/interview_format_choice.dart';
import '../widgets/interview_path_choice.dart';
import '../widgets/interview_personalization_card.dart';
import '../widgets/interview_promo_card.dart';

class InterviewStartScreen extends StatefulWidget {
  const InterviewStartScreen({super.key});

  @override
  State<InterviewStartScreen> createState() => _InterviewStartScreenState();
}

class _InterviewStartScreenState extends State<InterviewStartScreen> {
  int _selectedPathIndex = 0;
  int _selectedFormatIndex = 1;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        title: Text('routes.interviewStart'.tr()),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none_rounded),
          ),
       
        ],
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final contentWidth = constraints.maxWidth > 620 ? 620.0 : constraints.maxWidth;

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
                      InterviewPromoCard(colorScheme: colorScheme),
                      SizedBox(height: AppSpacing.lg.h),
                      InterviewSectionHeader(
                        titleKey: 'interview.targetCareerPath',
                        actionKey: 'interview.editPreferences',
                        onActionTap: () {},
                      ),
                      SizedBox(height: AppSpacing.sm.h),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            InterviewPathChoice(
                              titleKey: 'interview.frontendDeveloper',
                              icon: Icons.code_rounded,
                              selected: _selectedPathIndex == 0,
                              onTap: () => setState(() => _selectedPathIndex = 0),
                            ),
                            SizedBox(width: AppSpacing.md.w),
                            InterviewPathChoice(
                              titleKey: 'interview.productDesigner',
                              icon: Icons.design_services_rounded,
                              selected: _selectedPathIndex == 1,
                              onTap: () => setState(() => _selectedPathIndex = 1),
                            ),
                            SizedBox(width: AppSpacing.md.w),
                            InterviewPathChoice(
                              titleKey: 'interview.dataAnalyst',
                              icon: Icons.query_stats_rounded,
                              selected: _selectedPathIndex == 2,
                              onTap: () => setState(() => _selectedPathIndex = 2),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: AppSpacing.xl.h),
                      const InterviewSectionHeader(
                        titleKey: 'interview.chooseInterviewFormat',
                      ),
                      SizedBox(height: AppSpacing.sm.h),
                      InterviewFormatChoice(
                        titleKey: 'interview.behavioral',
                        descriptionKey: 'interview.behavioralDescription',
                        icon: Icons.groups_rounded,
                        color: colorScheme.secondary,
                        selected: _selectedFormatIndex == 0,
                        onTap: () => setState(() => _selectedFormatIndex = 0),
                      ),
                      SizedBox(height: AppSpacing.md.h),
                      InterviewFormatChoice(
                        titleKey: 'interview.technical',
                        descriptionKey: 'interview.technicalDescription',
                        icon: Icons.code_rounded,
                        color: colorScheme.primary,
                        selected: _selectedFormatIndex == 1,
                        onTap: () => setState(() => _selectedFormatIndex = 1),
                      ),
                      SizedBox(height: AppSpacing.md.h),
                      InterviewFormatChoice(
                        titleKey: 'interview.mockHr',
                        descriptionKey: 'interview.mockHrDescription',
                        icon: Icons.badge_rounded,
                        color: colorScheme.tertiary,
                        selected: _selectedFormatIndex == 2,
                        onTap: () => setState(() => _selectedFormatIndex = 2),
                      ),
                      SizedBox(height: AppSpacing.xl.h),
                      InterviewPersonalizationCard(colorScheme: colorScheme),
                      SizedBox(height: AppSpacing.xl.h),
                      SizedBox(
                        width: double.infinity,
                        child: AppButton(
                          label: 'interview.startInterview'.tr(),
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(AppRoutes.activeInterview);
                          },
                        ),
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
