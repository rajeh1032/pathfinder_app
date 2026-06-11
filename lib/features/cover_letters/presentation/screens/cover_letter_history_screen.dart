import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_gradient_back_button.dart';
import '../widgets/cover_letter_history/history_letter_card.dart';
import '../widgets/cover_letter_history/history_section_title.dart';

class CoverLetterHistoryScreen extends StatelessWidget {
  const CoverLetterHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppGradientBackButton(),
        title: Text('routes.coverLetterHistory'.tr()),
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(AppSpacing.md.w),
          children: [
            Text(
              'coverLetter.history.subtitle'.tr(),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                    height: 1.35,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            SizedBox(height: AppSpacing.lg.h),
            HistorySectionTitle('coverLetter.history.thisWeek'.tr()),
            SizedBox(height: AppSpacing.sm.h),
            const HistoryLetterCard(
              statusKey: 'coverLetter.history.strong',
              dateKey: 'jobs.applied.updated',
            ),
            SizedBox(height: AppSpacing.md.h),
            const HistoryLetterCard(
              statusKey: 'coverLetter.history.edited',
              dateKey: 'jobs.applied.submitted',
            ),
            SizedBox(height: AppSpacing.lg.h),
            HistorySectionTitle('coverLetter.history.earlier'.tr()),
            SizedBox(height: AppSpacing.sm.h),
            const HistoryLetterCard(
              statusKey: 'coverLetter.history.downloaded',
              dateKey: 'jobs.saved.savedAt',
            ),
          ],
        ),
      ),
    );
  }
}
