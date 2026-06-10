import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/routing/app_routes.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_button.dart';
import '../widgets/interview_answer_card.dart';
import '../widgets/interview_avatar_badge.dart';
import '../widgets/interview_progress_header.dart';
import '../widgets/interview_question_card.dart';

class ActiveInterviewScreen extends StatelessWidget {
  const ActiveInterviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        title: Text('routes.activeInterview'.tr()),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final contentWidth = constraints.maxWidth > 620 ? 620.0 : constraints.maxWidth;

            return ListView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: EdgeInsets.fromLTRB(
                AppSpacing.md.w,
                AppSpacing.sm.h,
                AppSpacing.md.w,
                AppSpacing.lg.h + bottomInset + AppSpacing.md.h,
              ),
              children: [
                Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: contentWidth),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InterviewProgressHeader(colorScheme: colorScheme),
                        SizedBox(height: AppSpacing.lg.h),
                        InterviewAvatarBadge(colorScheme: colorScheme),
                        SizedBox(height: AppSpacing.lg.h),
                        InterviewQuestionCard(colorScheme: colorScheme),
                        SizedBox(height: AppSpacing.lg.h),
                        InterviewAnswerCard(colorScheme: colorScheme),
                        SizedBox(height: AppSpacing.xxl.h),
                        SizedBox(
                          width: double.infinity,
                          child: AppButton(
                            label: 'interview.submitAnswer'.tr(),
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed(AppRoutes.interviewResult);
                            },
                          ),
                        ),
                        SizedBox(height: AppSpacing.sm.h),
                        TextButton(
                          onPressed: () {},
                          child: Text('interview.skipQuestion'.tr()),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
