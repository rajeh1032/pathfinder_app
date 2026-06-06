import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/routing/app_routes.dart';
import '../widgets/interview_section_header.dart';
import '../widgets/interview_personalization_card.dart';
import '../widgets/interview_start_widgets.dart';

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
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InterviewPromoCard(colorScheme: colorScheme),
              const SizedBox(height: 24),
              InterviewSectionHeader(
                titleKey: 'interview.targetCareerPath',
                actionKey: 'interview.editPreferences',
                onActionTap: () {},
              ),
              const SizedBox(height: 14),
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
                    const SizedBox(width: 16),
                    InterviewPathChoice(
                      titleKey: 'interview.productDesigner',
                      icon: Icons.design_services_rounded,
                      selected: _selectedPathIndex == 1,
                      onTap: () => setState(() => _selectedPathIndex = 1),
                    ),
                    const SizedBox(width: 16),
                    InterviewPathChoice(
                      titleKey: 'interview.dataAnalyst',
                      icon: Icons.query_stats_rounded,
                      selected: _selectedPathIndex == 2,
                      onTap: () => setState(() => _selectedPathIndex = 2),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),
              const InterviewSectionHeader(
                titleKey: 'interview.chooseInterviewFormat',
              ),
              const SizedBox(height: 14),
              InterviewFormatChoice(
                titleKey: 'interview.behavioral',
                descriptionKey: 'interview.behavioralDescription',
                icon: Icons.groups_rounded,
                color: const Color(0xFF5E8F67),
                selected: _selectedFormatIndex == 0,
                onTap: () => setState(() => _selectedFormatIndex = 0),
              ),
              const SizedBox(height: 16),
              InterviewFormatChoice(
                titleKey: 'interview.technical',
                descriptionKey: 'interview.technicalDescription',
                icon: Icons.code_rounded,
                color: colorScheme.primary,
                selected: _selectedFormatIndex == 1,
                onTap: () => setState(() => _selectedFormatIndex = 1),
              ),
              const SizedBox(height: 16),
              InterviewFormatChoice(
                titleKey: 'interview.mockHr',
                descriptionKey: 'interview.mockHrDescription',
                icon: Icons.badge_rounded,
                color: const Color(0xFFF0B84B),
                selected: _selectedFormatIndex == 2,
                onTap: () => setState(() => _selectedFormatIndex = 2),
              ),
              const SizedBox(height: 28),
              InterviewPersonalizationCard(colorScheme: colorScheme),
              const SizedBox(height: 28),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: () {
                    Navigator.of(context).pushNamed(AppRoutes.activeInterview);
                  },
                  icon: const Icon(Icons.play_arrow_rounded),
                  label: Text('interview.startInterview'.tr()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
