import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_spacing.dart';
import '../widgets/job_matching/boost_match_card.dart';
import '../widgets/job_matching/filter_chips.dart';
import '../widgets/job_matching/job_library_shortcuts.dart';
import '../widgets/job_matching/job_match_card.dart';
import '../widgets/job_matching/jobs_header.dart';
import '../widgets/job_matching/search_field.dart';

class JobMatchingScreen extends StatelessWidget {
  const JobMatchingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(child: JobsHeader()),
            SliverToBoxAdapter(child: SizedBox(height: AppSpacing.md.h)),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: AppSpacing.md.w),
              sliver: SliverList.list(
                children: [
                  const JobSearchField(),
                  SizedBox(height: AppSpacing.md.h),
                  const JobFilterChips(),
                  SizedBox(height: AppSpacing.md.h),
                  const JobLibraryShortcuts(),
                  SizedBox(height: AppSpacing.md.h),
                  const JobMatchCard(),
                  SizedBox(height: AppSpacing.lg.h),
                  const BoostMatchCard(),
                  SizedBox(height: AppSpacing.lg.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
