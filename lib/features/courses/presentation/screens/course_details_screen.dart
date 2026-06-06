import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/utils/custom_snackbar.dart';
import '../../../../core/widgets/app_error_view.dart';
import '../../data/repositories/demo_courses_repository.dart';
import '../../domain/use_cases/get_course_details_use_case.dart';
import '../../domain/use_cases/get_courses_use_case.dart';
import '../cubit/courses_cubit.dart';
import '../cubit/courses_state.dart';
import '../widgets/course_detail_body.dart';
import '../widgets/course_enroll_bar.dart';

class CourseDetailsScreen extends StatelessWidget {
  const CourseDetailsScreen({this.courseId, super.key});

  final String? courseId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        const repository = DemoCoursesRepository();
        return CoursesCubit(
          getCoursesUseCase: const GetCoursesUseCase(repository),
          getCourseDetailsUseCase: const GetCourseDetailsUseCase(repository),
        )..loadCourseDetails(courseId ?? 'advanced-react-design-patterns');
      },
      child: const _CourseDetailsView(),
    );
  }
}

class _CourseDetailsView extends StatelessWidget {
  const _CourseDetailsView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CoursesCubit, CoursesState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: context.colors.surface,
          bottomNavigationBar: state is CourseDetailsSuccess
              ? CourseEnrollBar(
                  course: state.course,
                  isSaved: state.isSaved,
                  isEnrolled: state.isEnrolled,
                  onSaveTap: () => _toggleSaved(context, state.course.id),
                  onEnrollTap: () => _enroll(context, state.course.id),
                )
              : null,
          body: SafeArea(
            child: Builder(
              builder: (context) {
                if (state is CourseDetailsSuccess) {
                  return CourseDetailBody(
                    course: state.course,
                    selectedTab: state.selectedTab,
                    isSaved: state.isSaved,
                    onShareTap: () =>
                        _shareCourse(context, state.course.titleKey),
                    onSaveTap: () => _toggleSaved(context, state.course.id),
                    onTabSelected: context.read<CoursesCubit>().selectDetailTab,
                  );
                }

                if (state is CoursesError) {
                  return AppErrorView(
                    message: state.messageKey.tr(),
                    onRetry: () =>
                        context.read<CoursesCubit>().loadCourseDetails(
                              'advanced-react-design-patterns',
                            ),
                  );
                }

                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
        );
      },
    );
  }

  void _toggleSaved(BuildContext context, String courseId) {
    final isSaved = context.read<CoursesCubit>().toggleSavedCourse(courseId);
    CustomSnackbar.showInfoKey(
      context: context,
      messageKey: isSaved ? 'courses.saved' : 'courses.unsaved',
    );
  }

  void _enroll(BuildContext context, String courseId) {
    final enrolled = context.read<CoursesCubit>().enrollInCourse(courseId);
    CustomSnackbar.showInfoKey(
      context: context,
      messageKey: enrolled ? 'courses.enrolled' : 'courses.alreadyEnrolled',
    );
  }

  void _shareCourse(BuildContext context, String titleKey) {
    CustomSnackbar.showInfo(
      context: context,
      message: 'courses.shareReady'.tr(args: [titleKey.tr()]),
    );
  }
}
