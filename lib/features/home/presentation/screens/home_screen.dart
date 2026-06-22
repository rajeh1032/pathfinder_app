// lib/features/home/presentation/screens/home_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/di/injection.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/home_entity.dart';
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
        title: const Text('PathFinder AI'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, '/notifications'),
            icon: const Icon(Icons.notifications_outlined),
          ),
        ],
        leading: IconButton(
          onPressed: () => Navigator.pushNamed(context, '/search'),
          icon: const Icon(
            Icons.search,
            color: AppColors.blueNotificationIcons,
          ),
        ),
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading || state is HomeInitial) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
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
      color: AppColors.primary,
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
                user: HomeUserModel(
                  name: summary.user.name,
                  cvScore: summary.cvScore ?? 0,
                  targetRole: summary.analyzedRole ?? '',
                ),
              ),
              SizedBox(height: 16.h),

              // Analyze CV + Chat with AI
              const HomeActionButtons(),
              SizedBox(height: 20.h),

              // Top Recommendation
              if (summary.analyzedRole != null)
                HomeRecommendationCard(
                  recommendation: HomeRecommendationModel(
                    title: summary.analyzedRole!,
                    badge: 'Match',
                    badgeColor: '#6366F1',
                    reason: 'home.basedOnYourStack'.tr(),
                  ),
                ),
              if (summary.analyzedRole != null) SizedBox(height: 16.h),

              // CV Score + AI Insight
              HomeScoreInsightRow(cvScore: summary.cvScore ?? 0),
              SizedBox(height: 20.h),

              // Roadmap
              if (summary.roadmap != null)
                HomeRoadmapCard(
                  roadmap: HomeRoadmapModel(
                    title: summary.roadmap!.title,
                    progress: summary.roadmap!.progress / 100,
                    status: '${summary.roadmap!.progress}%',
                  ),
                ),
              if (summary.roadmap != null) SizedBox(height: 20.h),

              // Skill Gap
              if (summary.missingSkills.isNotEmpty)
                HomeSkillGapSection(
                  skills: summary.missingSkills
                      .take(5)
                      .map((s) => HomeSkillGapModel(
                    skill: s,
                    level: SkillLevel.tailwind,
                  ))
                      .toList(),
                ),
              if (summary.missingSkills.isNotEmpty) SizedBox(height: 20.h),

              // Jobs
              if (summary.jobMatches.isNotEmpty)
                HomeJobsSection(
                  jobs: summary.jobMatches
                      .map((j) => HomeJobModel(
                    company: j.company,
                    logo: j.company.isNotEmpty
                        ? j.company[0].toUpperCase()
                        : 'J',
                    title: j.jobTitle,
                    location: j.isRemote ? 'Remote' : '',
                    salaryRange: j.salaryRange ?? '',
                    isRemote: j.isRemote,
                  ))
                      .toList(),
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
                size: 48.sp, color: AppColors.error),
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
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh_rounded),
              label: Text('common.retry'.tr()),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}