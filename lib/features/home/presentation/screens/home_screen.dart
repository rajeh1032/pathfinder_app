// lib/features/home/presentation/screens/home_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:pathfinder_app/core/di/di.dart';
import 'package:pathfinder_app/features/home/domain/entites/home_entity.dart';

import '../../../../core/utils/custom_button.dart';
import '../cubit/home_cubit.dart';
import '../cubit/home_state.dart';
import '../widgets/home_action_button.dart';
import '../widgets/home_jobs_section.dart';
import '../widgets/home_recommendation_card.dart';
import '../widgets/home_roadmap_card.dart';
import '../widgets/home_score_insight_row.dart';
import '../widgets/home_skill_gap_section.dart';
import '../widgets/home_dashboard.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<HomeCubit>()..loadHome(),
      child: const _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('routes.home'.tr()),
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, '/notifications'),
            icon: const Icon(Icons.notifications_outlined),
          ),
        ],
        leading: IconButton(
          onPressed: () => Navigator.pushNamed(context, '/search'),
          icon: const Icon(Icons.search),
        ),
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading || state is HomeInitial) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is HomeError) {
            return _ErrorView(
              message: state.message,
              onRetry: () => context.read<HomeCubit>().refresh(),
            );
          }

          if (state is HomeLoaded) {
            return _HomeContent(summary: state.summary);
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}

// ─── Home Content ─────────────────────────────────────────────
class _HomeContent extends StatelessWidget {
  final HomeSummaryEntity summary;

  const _HomeContent({required this.summary});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => context.read<HomeCubit>().refresh(),
      child: SafeArea(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 👋 Hello + CV Score circle
              HomeHeader(
                user: summary.user,
                cvScore: summary.cvScore ?? 0,
              ),
              SizedBox(height: 16.h),

              // Analyze CV + Chat with AI
              const HomeActionButtons(),
              SizedBox(height: 20.h),

              // Top Recommendation
              if (summary.analyzedRole != null)
                HomeRecommendationCard(
                  title: summary.analyzedRole!,
                ),
              if (summary.analyzedRole != null) SizedBox(height: 16.h),

              // CV Score + AI Insight
              HomeScoreInsightRow(
                cvScore: summary.cvScore ?? 0,
                analyzedRole: summary.analyzedRole,
                topSkill: summary.missingSkills.isEmpty
                    ? null
                    : summary.missingSkills.first,
              ),
              SizedBox(height: 20.h),

              // Roadmap
              if (summary.roadmap != null)
                HomeRoadmapCard(
                  roadmap: summary.roadmap!,
                ),
              if (summary.roadmap != null) SizedBox(height: 20.h),

              // Skill Gap
              if (summary.missingSkills.isNotEmpty)
                HomeSkillGapSection(
                  skills: summary.missingSkills.take(5).toList(),
                ),
              if (summary.missingSkills.isNotEmpty) SizedBox(height: 20.h),

              // Jobs
              if (summary.jobMatches.isNotEmpty)
                HomeJobsSection(
                  jobs: summary.jobMatches,
                ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Error View ───────────────────────────────────────────────
class _ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorView({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline_rounded,
                size: 48.sp, color: colorScheme.error),
            SizedBox(height: 16.h),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            SizedBox(height: 16.h),
            CustomButton(
              onPressed: onRetry,
              icon: Icons.refresh_rounded,
              labelKey: 'common.retry',
            ),
          ],
        ),
      ),
    );
  }
}
