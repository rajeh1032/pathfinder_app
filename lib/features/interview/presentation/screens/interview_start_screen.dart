import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/di/di.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../core/routing/route_arguments.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/utils/custom_button.dart';
import '../../../../core/utils/custom_snackbar.dart';
import '../../../../core/widgets/app_empty_view.dart';
import '../../../../core/widgets/app_error_view.dart';
import '../../../../core/widgets/app_loading.dart';
import '../../domain/entities/interview_career_path.dart';
import '../cubit/interview_start_cubit.dart';
import '../widgets/interview_career_path_card.dart';
import '../widgets/interview_format_choice.dart';
import '../widgets/interview_personalization_card.dart';
import '../widgets/interview_promo_card.dart';
import '../widgets/interview_section_header.dart';

class InterviewStartScreen extends StatefulWidget {
  const InterviewStartScreen({super.key});

  @override
  State<InterviewStartScreen> createState() => _InterviewStartScreenState();
}

class _InterviewStartScreenState extends State<InterviewStartScreen> {
  late final InterviewStartCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = getIt<InterviewStartCubit>();
    _cubit.loadCareerPaths();
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  String? _selectedCareerPathName(InterviewStartState state) {
    final selectedId = state.selectedCareerPathId;
    if (selectedId == null) return null;
    for (final path in state.careerPaths) {
      if (path.id == selectedId) return path.name;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return BlocProvider.value(
      value: _cubit,
      child: Scaffold(
        backgroundColor: colorScheme.surface,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('routes.interviewStart'.tr()),
          actions: [
            IconButton(
              tooltip: 'routes.interviewHistory'.tr(),
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.interviewHistory);
              },
              icon: const Icon(Icons.history_rounded),
            ),
          ],
        ),
        body: SafeArea(
          child: BlocConsumer<InterviewStartCubit, InterviewStartState>(
            listenWhen: (previous, current) =>
                previous.errorMessage != current.errorMessage ||
                previous.createdSession != current.createdSession,
            listener: (context, state) {
              final errorMessage = state.errorMessage;
              if (errorMessage != null) {
                CustomSnackbar.showError(
                    context: context, message: errorMessage);
              }

              final session = state.createdSession;
              if (session != null) {
                final sessionId = session.id;
                context.read<InterviewStartCubit>().clearCreatedSession();
                Navigator.of(context).pushNamed(
                  AppRoutes.activeInterview,
                  arguments: RouteArguments(id: sessionId),
                );
              }
            },
            builder: (context, state) {
              return LayoutBuilder(
                builder: (context, constraints) {
                  final contentWidth =
                      constraints.maxWidth > 620 ? 620.0 : constraints.maxWidth;

                  return SingleChildScrollView(
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InterviewPromoCard(colorScheme: colorScheme),
                            SizedBox(height: AppSpacing.lg.h),
                            InterviewSectionHeader(
                              titleKey: 'interview.targetCareerPath',
                              actionKey: 'interview.editPreferences',
                              onActionTap: () {
                                Navigator.of(context)
                                    .pushNamed(AppRoutes.settings);
                              },
                            ),
                            SizedBox(height: AppSpacing.sm.h),
                            _CareerPathsSection(
                              isLoading: state.isLoading,
                              careerPaths: state.careerPaths,
                              selectedCareerPathId: state.selectedCareerPathId,
                              errorMessage: state.errorMessage,
                              onCareerPathSelected: context
                                  .read<InterviewStartCubit>()
                                  .selectCareerPath,
                              onRetry: _cubit.loadCareerPaths,
                            ),
                            SizedBox(height: AppSpacing.xl.h),
                            const InterviewSectionHeader(
                              titleKey: 'interview.chooseInterviewFormat',
                            ),
                            SizedBox(height: AppSpacing.sm.h),
                            InterviewFormatChoice(
                              titleKey: 'interview.behavioral',
                              descriptionKey: 'interview.behavioralDescription',
                              icon: Icons.groups_rounded,
                              color: colorScheme.secondary,
                              selected:
                                  state.selectedInterviewType == 'behavioral',
                              onTap: () => context
                                  .read<InterviewStartCubit>()
                                  .selectInterviewType('behavioral'),
                            ),
                            SizedBox(height: AppSpacing.md.h),
                            InterviewFormatChoice(
                              titleKey: 'interview.technical',
                              descriptionKey: 'interview.technicalDescription',
                              icon: Icons.code_rounded,
                              color: colorScheme.primary,
                              selected:
                                  state.selectedInterviewType == 'technical',
                              onTap: () => context
                                  .read<InterviewStartCubit>()
                                  .selectInterviewType('technical'),
                            ),
                            SizedBox(height: AppSpacing.md.h),
                            InterviewFormatChoice(
                              titleKey: 'interview.mockHr',
                              descriptionKey: 'interview.mockHrDescription',
                              icon: Icons.badge_rounded,
                              color: colorScheme.tertiary,
                              selected:
                                  state.selectedInterviewType == 'mock_hr',
                              onTap: () => context
                                  .read<InterviewStartCubit>()
                                  .selectInterviewType('mock_hr'),
                            ),
                            SizedBox(height: AppSpacing.xl.h),
                            InterviewPersonalizationCard(
                              colorScheme: colorScheme,
                              interviewType: state.selectedInterviewType,
                              careerPathName: _selectedCareerPathName(state),
                            ),
                            SizedBox(height: AppSpacing.xl.h),
                            SizedBox(
                              width: double.infinity,
                              child: CustomButton(
                                labelKey: 'interview.startInterview',
                                isLoading: state.isSubmitting,
                                onPressed: state.canStart
                                    ? () => context
                                        .read<InterviewStartCubit>()
                                        .startInterview()
                                    : null,
                              ),
                            ),
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
}

class _CareerPathsSection extends StatelessWidget {
  const _CareerPathsSection({
    required this.isLoading,
    required this.careerPaths,
    required this.selectedCareerPathId,
    required this.errorMessage,
    required this.onCareerPathSelected,
    required this.onRetry,
  });

  final bool isLoading;
  final List<InterviewCareerPath> careerPaths;
  final String? selectedCareerPathId;
  final String? errorMessage;
  final ValueChanged<String> onCareerPathSelected;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    if (isLoading && careerPaths.isEmpty) {
      return const SizedBox(height: 168, child: AppLoading());
    }

    if (errorMessage != null && careerPaths.isEmpty) {
      return SizedBox(
        height: 168,
        child: AppErrorView(message: errorMessage, onRetry: onRetry),
      );
    }

    if (careerPaths.isEmpty) {
      return const SizedBox(height: 168, child: AppEmptyView());
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (var index = 0; index < careerPaths.length; index++) ...[
            InterviewCareerPathCard(
              title: careerPaths[index].name,
              description: careerPaths[index].description,
              icon: _iconForIndex(index),
              selected: selectedCareerPathId == careerPaths[index].id,
              onTap: () => onCareerPathSelected(careerPaths[index].id),
            ),
            if (index != careerPaths.length - 1)
              SizedBox(width: AppSpacing.md.w),
          ],
        ],
      ),
    );
  }

  IconData _iconForIndex(int index) {
    const icons = [
      Icons.code_rounded,
      Icons.design_services_rounded,
      Icons.query_stats_rounded,
      Icons.work_outline_rounded,
      Icons.school_rounded,
    ];
    return icons[index % icons.length];
  }
}
