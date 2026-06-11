import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_gradient_back_button.dart';
import '../widgets/applied_jobs/applied_job_card.dart';
import '../widgets/applied_jobs/applied_jobs_header.dart';

class AppliedJobsScreen extends StatelessWidget {
  const AppliedJobsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppGradientBackButton(),
        title: Text('routes.appliedJobs'.tr()),
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(AppSpacing.md.w),
          children: [
            const AppliedJobsHeader(),
            SizedBox(height: AppSpacing.md.h),
            const AppliedJobCard(
              statusKey: 'jobs.applied.statusReview',
              dateKey: 'jobs.applied.submitted',
              accent: AppliedJobAccent.primary,
            ),
            SizedBox(height: AppSpacing.md.h),
            const AppliedJobCard(
              statusKey: 'jobs.applied.statusInterview',
              dateKey: 'jobs.applied.updated',
              accent: AppliedJobAccent.secondary,
            ),
          ],
        ),
      ),
    );
  }
}
