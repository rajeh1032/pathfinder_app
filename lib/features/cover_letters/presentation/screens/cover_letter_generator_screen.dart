import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../widgets/cover_letter/cover_header.dart';
import '../widgets/cover_letter/generate_button.dart';
import '../widgets/cover_letter/generated_draft_card.dart';
import '../widgets/cover_letter/match_score_card.dart';
import '../widgets/cover_letter/personalize_card.dart';
import '../widgets/cover_letter/review_insights_card.dart';
import '../widgets/cover_letter/selected_role_card.dart';
import '../widgets/cover_letter/target_goal_card.dart';

class CoverLetterGeneratorScreen extends StatelessWidget {
  const CoverLetterGeneratorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: EdgeInsets.fromLTRB(
                AppSpacing.md.w,
                AppSpacing.sm.h,
                AppSpacing.md.w,
                AppSpacing.xl.h,
              ),
              sliver: SliverList.list(
                children: [
                  const CoverHeader(),
                  SizedBox(height: AppSpacing.md.h),
                  const SelectedRoleCard(),
                  SizedBox(height: AppSpacing.md.h),
                  const PersonalizeCard(),
                  SizedBox(height: AppSpacing.md.h),
                  const TargetGoalCard(),
                  SizedBox(height: AppSpacing.md.h),
                  const GenerateCoverLetterButton(),
                  SizedBox(height: AppSpacing.md.h),
                  const MatchScoreCard(),
                  SizedBox(height: AppSpacing.md.h),
                  const ReviewInsightsCard(),
                  SizedBox(height: AppSpacing.md.h),
                  const GeneratedDraftCard(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
