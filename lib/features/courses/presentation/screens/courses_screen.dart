import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../core/routing/route_arguments.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_gradient_back_button.dart';
import '../../../../core/widgets/app_search_filters.dart';
import '../../../../core/widgets/app_gradient_title.dart';
import '../../../../core/widgets/app_error_view.dart';
import '../../data/repositories/demo_courses_repository.dart';
import '../../domain/use_cases/get_course_details_use_case.dart';
import '../../domain/use_cases/get_courses_use_case.dart';
import '../cubit/courses_cubit.dart';
import '../cubit/courses_state.dart';
import '../widgets/course_tile.dart';

class CoursesScreen extends StatelessWidget {
  const CoursesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        const repository = DemoCoursesRepository();
        return CoursesCubit(
          getCoursesUseCase: const GetCoursesUseCase(repository),
          getCourseDetailsUseCase: const GetCourseDetailsUseCase(repository),
        )..loadCourses();
      },
      child: const _CoursesView(),
    );
  }
}

class _CoursesView extends StatelessWidget {
  const _CoursesView();

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Scaffold(
      backgroundColor: colors.surface,
      appBar: AppBar(
        leading: const AppGradientBackButton(),
        title: const AppGradientTitle(),
      ),
      body: BlocBuilder<CoursesCubit, CoursesState>(
        builder: (context, state) {
          if (state is CoursesSuccess) {
            return SafeArea(
              child: ListView.separated(
                padding: const EdgeInsets.all(AppSpacing.lg),
                itemCount: state.courses.length + 2,
                separatorBuilder: (_, __) => const SizedBox(
                  height: AppSpacing.md,
                ),
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return _SearchAndFilters(
                      query: state.query,
                      selectedFilter: state.selectedFilter,
                    );
                  }
                  if (index == 1) {
                    return Text(
                      'courses.title'.tr(),
                      style: AppTextStyles.headlineLarge(colors.onSurface),
                    );
                  }
                  final course = state.courses[index - 2];
                  return CourseTile(
                    course: course,
                    isSaved: state.savedCourseIds.contains(course.id),
                    onSaveTap: () => _toggleSaved(context, course.id),
                    onTap: () => Navigator.pushNamed(
                      context,
                      AppRoutes.courseDetails,
                      arguments: RouteArguments(id: course.id),
                    ),
                  );
                },
              ),
            );
          }

          if (state is CoursesEmpty) {
            return SafeArea(
              child: ListView(
                padding: const EdgeInsets.all(AppSpacing.lg),
                children: [
                  _SearchAndFilters(
                    query: state.query,
                    selectedFilter: state.selectedFilter,
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  AppErrorView(
                    message: 'courses.empty'.tr(),
                    onRetry: () => context.read<CoursesCubit>().loadCourses(),
                  ),
                ],
              ),
            );
          }

          if (state is CoursesError) {
            return AppErrorView(
              message: state.messageKey.tr(),
              onRetry: () => context.read<CoursesCubit>().loadCourses(),
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  void _toggleSaved(BuildContext context, String courseId) {
    final isSaved = context.read<CoursesCubit>().toggleSavedCourse(courseId);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          (isSaved ? 'courses.saved' : 'courses.unsaved').tr(),
        ),
      ),
    );
  }
}

class _SearchAndFilters extends StatelessWidget {
  const _SearchAndFilters({
    required this.query,
    required this.selectedFilter,
  });

  final String query;
  final CourseFilter? selectedFilter;

  @override
  Widget build(BuildContext context) {
    return AppSearchFilters(
      key: ValueKey(query),
      searchHintText: 'roadmaps.searchHint'.tr(),
      onSearchChanged: context.read<CoursesCubit>().searchCourses,
      filterChips: [
        AppFilterChip(
          icon: Icons.payments_outlined,
          label: 'roadmaps.priceFilter'.tr(),
          selected: selectedFilter == CourseFilter.price,
          onTap: () => context.read<CoursesCubit>().toggleFilter(
                CourseFilter.price,
              ),
        ),
        AppFilterChip(
          icon: Icons.schedule_outlined,
          label: 'roadmaps.durationFilter'.tr(),
          selected: selectedFilter == CourseFilter.duration,
          onTap: () => context.read<CoursesCubit>().toggleFilter(
                CourseFilter.duration,
              ),
        ),
        AppFilterChip(
          icon: Icons.bar_chart,
          label: 'roadmaps.levelFilter'.tr(),
          selected: selectedFilter == CourseFilter.level,
          onTap: () => context.read<CoursesCubit>().toggleFilter(
                CourseFilter.level,
              ),
        ),
      ],
    );
  }
}
