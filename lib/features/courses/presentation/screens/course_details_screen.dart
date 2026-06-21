import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/di/di.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/utils/custom_button.dart';
import '../../../../core/utils/custom_snackbar.dart';
import '../../../../core/widgets/app_error_view.dart';
import '../../../../core/widgets/app_gradient_back_button.dart';
import '../cubit/course_details_cubit.dart';
import '../cubit/course_details_state.dart';
import '../widgets/course_details_content.dart';

class CourseDetailsScreen extends StatelessWidget {
  const CourseDetailsScreen({this.courseId, super.key});
  final String? courseId;

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (_) => getIt<CourseDetailsCubit>()..load(courseId),
        child: _CourseDetailsView(courseId: courseId),
      );
}

class _CourseDetailsView extends StatelessWidget {
  const _CourseDetailsView({required this.courseId});
  final String? courseId;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CourseDetailsCubit, CourseDetailsState>(
      listenWhen: (previous, current) =>
          previous.feedbackSerial != current.feedbackSerial,
      listener: (context, state) {
        final key = state.feedbackKey;
        if (key == null) return;
        if (key.endsWith('Failed') ||
            key.contains('invalid') ||
            key.contains('inconsistent')) {
          CustomSnackbar.showErrorKey(context: context, messageKey: key);
        } else {
          CustomSnackbar.showInfoKey(context: context, messageKey: key);
        }
      },
      builder: (context, state) => PopScope<bool>(
        canPop: false,
        onPopInvokedWithResult: (didPop, _) {
          if (!didPop) Navigator.pop(context, state.changed);
        },
        child: Scaffold(
          backgroundColor: context.colors.surface,
          appBar: AppBar(
            leading: AppGradientBackButton(
              onPressed: () => Navigator.pop(context, state.changed),
            ),
            title: Text('courses.detailsTitle'.tr()),
          ),
          bottomNavigationBar:
              state.course == null ? null : _CourseActions(state: state),
          body: SafeArea(
            top: false,
            child: _content(context, state),
          ),
        ),
      ),
    );
  }

  Widget _content(BuildContext context, CourseDetailsState state) {
    if (state.status == CourseDetailsStatus.success) {
      final cubit = context.read<CourseDetailsCubit>();
      return CourseDetailsContent(
        course: state.course!,
        progress: state.progress,
        status: state.enrollmentStatus,
        isDirty: state.isDirty,
        isUpdating: state.updateLoading,
        onProgress: cubit.stageProgress,
        onStatus: cubit.stageStatus,
        onUpdate: cubit.updateEnrollment,
        onOpenProvider: () => _openProvider(context, state.course!.url),
      );
    }
    if (state.status == CourseDetailsStatus.loading ||
        state.status == CourseDetailsStatus.initial) {
      return Semantics(
        label: 'courses.loadingDetails'.tr(),
        child: const Center(child: CircularProgressIndicator()),
      );
    }
    return AppErrorView(
      message: (state.errorKey ?? 'courses.serverError').tr(),
      onRetry: () => context.read<CourseDetailsCubit>().load(courseId),
    );
  }

  Future<void> _openProvider(BuildContext context, String? value) async {
    final uri = value == null ? null : Uri.tryParse(value);
    final valid = uri != null &&
        (uri.scheme == 'http' || uri.scheme == 'https') &&
        uri.host.isNotEmpty;
    if (!valid || !await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      if (context.mounted) {
        CustomSnackbar.showErrorKey(
          context: context,
          messageKey: 'courses.providerLinkError',
        );
      }
    }
  }
}

class _CourseActions extends StatelessWidget {
  const _CourseActions({required this.state});
  final CourseDetailsState state;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CourseDetailsCubit>();
    final course = state.course!;
    return SafeArea(
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: context.colors.surface,
          border: Border(top: BorderSide(color: context.colors.outlineVariant)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(
            children: [
              Expanded(
                child: CustomButton(
                  labelKey: course.isSaved
                      ? 'courses.unsaveAction'
                      : 'courses.saveAction',
                  variant: CustomButtonVariant.outline,
                  isLoading: state.saveLoading,
                  onPressed: state.saveLoading ? null : cubit.toggleSave,
                ),
              ),
              if (course.enrollment == null) ...[
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: CustomButton(
                    labelKey: 'courses.enrollAction',
                    isLoading: state.enrollLoading,
                    onPressed: state.enrollLoading ? null : cubit.enroll,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
