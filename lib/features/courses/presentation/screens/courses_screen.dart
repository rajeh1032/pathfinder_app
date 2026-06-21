import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/di.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../core/routing/route_arguments.dart';
import '../../../../core/utils/custom_snackbar.dart';
import '../../../../core/widgets/app_empty_view.dart';
import '../../../../core/widgets/app_error_view.dart';
import '../cubit/courses_catalog_cubit.dart';
import '../cubit/courses_catalog_state.dart';
import '../widgets/courses_catalog_content.dart';
import '../widgets/courses_catalog_header.dart';

class CoursesScreen extends StatelessWidget {
  const CoursesScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (_) => getIt<CoursesCatalogCubit>()..loadInitial(),
        child: const _CoursesView(),
      );
}

class _CoursesView extends StatelessWidget {
  const _CoursesView();

  @override
  Widget build(BuildContext context) {
    return BlocListener<CoursesCatalogCubit, CoursesCatalogState>(
      listenWhen: (previous, current) =>
          previous.feedbackSerial != current.feedbackSerial,
      listener: (context, state) {
        final key = state.feedbackKey;
        if (key == null) return;
        if (key == 'courses.saveFailed') {
          CustomSnackbar.showErrorKey(context: context, messageKey: key);
        } else {
          CustomSnackbar.showInfoKey(context: context, messageKey: key);
        }
      },
      child: Scaffold(
        backgroundColor: context.colors.surface,
        appBar: AppBar(title: Text('courses.title'.tr())),
        body: SafeArea(
          top: false,
          child: BlocBuilder<CoursesCatalogCubit, CoursesCatalogState>(
            builder: (context, state) => Column(
              children: [
                CoursesCatalogHeader(
                  state: state,
                  onTabSelected: context.read<CoursesCatalogCubit>().selectTab,
                  onSearch: context.read<CoursesCatalogCubit>().search,
                  onFilters: context.read<CoursesCatalogCubit>().applyFilters,
                ),
                const SizedBox(height: 12),
                Expanded(child: _content(context, state)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _content(BuildContext context, CoursesCatalogState state) {
    if (state.status == CoursesCatalogStatus.loading ||
        state.status == CoursesCatalogStatus.initial) {
      return Semantics(
        label: 'courses.loading'.tr(),
        child: const Center(child: CircularProgressIndicator()),
      );
    }
    if (_isError(state.status)) {
      return AppErrorView(
        message: (state.errorKey ?? 'courses.serverError').tr(),
        onRetry: context.read<CoursesCatalogCubit>().loadInitial,
      );
    }
    if (state.requiredAction == 'upload_cv') {
      return CoursesUploadCvView(
        onPressed: () => Navigator.pushNamed(context, AppRoutes.cvUpload),
      );
    }
    if (state.status == CoursesCatalogStatus.empty) {
      return AppEmptyView(message: _emptyKey(state.tab).tr());
    }
    return CoursesCatalogContent(
      state: state,
      onRefresh: context.read<CoursesCatalogCubit>().refresh,
      onLoadMore: context.read<CoursesCatalogCubit>().loadMore,
      onSave: context.read<CoursesCatalogCubit>().toggleSave,
      onOpen: (course) async {
        final changed = await Navigator.pushNamed<Object?>(
          context,
          AppRoutes.courseDetails,
          arguments: RouteArguments(id: course.id),
        );
        if (changed == true && context.mounted) {
          await context.read<CoursesCatalogCubit>().refresh();
        }
      },
    );
  }

  bool _isError(CoursesCatalogStatus status) =>
      status == CoursesCatalogStatus.networkError ||
      status == CoursesCatalogStatus.unauthorized ||
      status == CoursesCatalogStatus.error;

  String _emptyKey(CoursesCatalogTab tab) => switch (tab) {
        CoursesCatalogTab.discover => 'courses.empty.discover',
        CoursesCatalogTab.recommended => 'courses.empty.recommended',
        CoursesCatalogTab.saved => 'courses.empty.saved',
        CoursesCatalogTab.learning => 'courses.empty.learning',
      };
}
