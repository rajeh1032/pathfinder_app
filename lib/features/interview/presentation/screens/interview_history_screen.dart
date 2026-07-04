import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/di/di.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../core/routing/route_arguments.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_empty_view.dart';
import '../../../../core/widgets/app_error_view.dart';
import '../../../../core/widgets/app_loading.dart';
import '../../domain/entities/interview_history_item.dart';
import '../cubit/interview_history_cubit.dart';
import '../widgets/interview_history_filter_bar.dart';
import '../widgets/interview_history_search_field.dart';
import '../widgets/interview_history_session_card.dart';
import '../widgets/interview_history_stats_card.dart';

class InterviewHistoryScreen extends StatefulWidget {
  const InterviewHistoryScreen({super.key});

  @override
  State<InterviewHistoryScreen> createState() => _InterviewHistoryScreenState();
}

class _InterviewHistoryScreenState extends State<InterviewHistoryScreen> {
  late final InterviewHistoryCubit _cubit;
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _cubit = getIt<InterviewHistoryCubit>()..loadHistory();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _searchController.dispose();
    _cubit.close();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final position = _scrollController.position;
    if (position.pixels >= position.maxScrollExtent - 240) {
      _cubit.loadMore();
    }
  }

  void _openResult(InterviewHistoryItem item) {
    Navigator.of(context).pushNamed(
      AppRoutes.interviewResult,
      arguments: RouteArguments(id: item.id),
    );
  }

  void _retake() {
    Navigator.of(context).pushReplacementNamed(AppRoutes.interviewStart);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return BlocProvider.value(
      value: _cubit,
      child: Scaffold(
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
        ),
        body: SafeArea(
          child: BlocBuilder<InterviewHistoryCubit, InterviewHistoryState>(
            builder: (context, state) {
              return LayoutBuilder(
                builder: (context, constraints) {
                  final contentWidth = constraints.maxWidth > 720
                      ? 720.0
                      : constraints.maxWidth;

                  return SingleChildScrollView(
                    controller: _scrollController,
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
                            InterviewHistoryStatsCard(
                              totalInterviews:
                                  '${state.summary?.totalInterviews ?? 0}',
                              averageScore:
                                  _scoreText(state.summary?.averageScore),
                              bestScore: _scoreText(state.summary?.bestScore),
                              latestScore:
                                  _scoreText(state.summary?.latestScore),
                            ),
                            SizedBox(height: AppSpacing.lg.h),
                            InterviewHistorySearchField(
                              controller: _searchController,
                              onChanged: _cubit.search,
                            ),
                            SizedBox(height: AppSpacing.md.h),
                            InterviewHistoryFilterBar(
                              selectedIndex: state.selectedFilterIndex,
                              onChanged: _cubit.selectFilter,
                            ),
                            SizedBox(height: AppSpacing.lg.h),
                            _buildList(state),
                            if (state.isLoadingMore) ...[
                              SizedBox(height: AppSpacing.md.h),
                              const Center(
                                child: Padding(
                                  padding: EdgeInsets.all(AppSpacing.sm),
                                  child: SizedBox.square(
                                    dimension: 24,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildList(InterviewHistoryState state) {
    if (state.isLoading && !state.hasItems) {
      return const SizedBox(height: 220, child: AppLoading());
    }

    if (state.errorMessage != null && !state.hasItems) {
      return SizedBox(
        height: 220,
        child: AppErrorView(
          message: state.errorMessage,
          onRetry: _cubit.loadHistory,
        ),
      );
    }

    if (!state.hasItems) {
      return const SizedBox(height: 220, child: AppEmptyView());
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (var index = 0; index < state.items.length; index++) ...[
          InterviewHistorySessionCard(
            item: state.items[index],
            onViewResults: () => _openResult(state.items[index]),
            onRetake: _retake,
          ),
          if (index != state.items.length - 1)
            SizedBox(height: AppSpacing.md.h),
        ],
      ],
    );
  }

  String _scoreText(double? score) {
    if (score == null) return '—';
    return '${score.round()}%';
  }
}
