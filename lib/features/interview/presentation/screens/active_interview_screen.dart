import 'dart:async';

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
import '../cubit/interview_active_cubit.dart';
import '../widgets/interview_avatar_badge.dart';
import '../widgets/interview_progress_header.dart';
import '../widgets/interview_question_card.dart';

class ActiveInterviewScreen extends StatefulWidget {
  const ActiveInterviewScreen({this.sessionId, super.key});

  final String? sessionId;

  @override
  State<ActiveInterviewScreen> createState() => _ActiveInterviewScreenState();
}

class _ActiveInterviewScreenState extends State<ActiveInterviewScreen> {
  late final InterviewActiveCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = getIt<InterviewActiveCubit>();
    _cubit.loadSessionQuestions(widget.sessionId);
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return BlocProvider.value(
      value: _cubit,
      child: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, _) {
          if (didPop) return;
          unawaited(_cubit.cancelSession());
          Navigator.of(context).pop();
        },
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: colorScheme.surface,
          appBar: AppBar(
            title: Text('routes.activeInterview'.tr()),
          ),
          body: SafeArea(
            child: BlocConsumer<InterviewActiveCubit, InterviewActiveState>(
              listenWhen: (previous, current) =>
                  previous.errorMessage != current.errorMessage,
              listener: (context, state) {
                final message = state.errorMessage;
                if (message != null) {
                  CustomSnackbar.showError(context: context, message: message);
                }
              },
              builder: (context, state) {
                if (state.isLoading && !state.hasQuestions) {
                  return const AppLoading();
                }

                if (state.errorMessage != null && !state.hasQuestions) {
                  return AppErrorView(
                    message: state.errorMessage,
                    onRetry: () =>
                        _cubit.loadSessionQuestions(widget.sessionId),
                  );
                }

                final sessionQuestions = state.sessionQuestions;
                final currentQuestion = state.currentQuestion;
                if (sessionQuestions == null || currentQuestion == null) {
                  return const AppEmptyView();
                }

                return LayoutBuilder(
                  builder: (context, constraints) {
                    final contentWidth = constraints.maxWidth > 620
                        ? 620.0
                        : constraints.maxWidth;

                    return ListView(
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      padding: EdgeInsets.fromLTRB(
                        AppSpacing.md.w,
                        AppSpacing.sm.h,
                        AppSpacing.md.w,
                        AppSpacing.lg.h,
                      ),
                      children: [
                        Center(
                          child: ConstrainedBox(
                            constraints: BoxConstraints(maxWidth: contentWidth),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                InterviewProgressHeader(
                                  colorScheme: colorScheme,
                                  currentQuestion: state.currentQuestionNumber,
                                  totalQuestions: state.totalQuestions,
                                  progress: state.totalQuestions == 0
                                      ? 0
                                      : state.currentQuestionNumber /
                                          state.totalQuestions,
                                ),
                                SizedBox(height: AppSpacing.lg.h),
                                InterviewAvatarBadge(colorScheme: colorScheme),
                                SizedBox(height: AppSpacing.lg.h),
                                InterviewQuestionCard(
                                  colorScheme: colorScheme,
                                  question: currentQuestion.question,
                                  options: currentQuestion.options,
                                  selectedOptionIndex:
                                      currentQuestion.selectedOptionIndex,
                                  isEnabled: !state.isActionLoading,
                                  onOptionSelected: (index) async {
                                    await _cubit.selectOption(index);
                                  },
                                ),
                                SizedBox(height: AppSpacing.xl.h),
                                Row(
                                  children: [
                                    Expanded(
                                      child: CustomButton(
                                        labelKey: 'interview.previousQuestion',
                                        variant: CustomButtonVariant.outline,
                                        onPressed: state.isFirstQuestion ||
                                                state.isActionLoading
                                            ? null
                                            : () => _cubit.goBack(),
                                      ),
                                    ),
                                    SizedBox(width: AppSpacing.md.w),
                                    Expanded(
                                      child: CustomButton(
                                        labelKey: 'interview.skipQuestion',
                                        variant: CustomButtonVariant
                                            .destructiveOutline,
                                        onPressed: state.isActionLoading
                                            ? null
                                            : () async {
                                                await _cubit
                                                    .skipCurrentQuestion();
                                              },
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: AppSpacing.md.h),
                                SizedBox(
                                  width: double.infinity,
                                  child: CustomButton(
                                    labelKey: state.isLastQuestion
                                        ? 'interview.submitInterview'
                                        : 'interview.nextQuestion',
                                    isLoading: state.isActionLoading,
                                    onPressed: state.isActionLoading
                                        ? null
                                        : () async {
                                            if (state.isLastQuestion) {
                                              final failure =
                                                  await _cubit.finishSession();
                                              if (!context.mounted ||
                                                  failure != null) {
                                                return;
                                              }
                                              Navigator.of(context)
                                                  .pushReplacementNamed(
                                                AppRoutes.interviewResult,
                                                arguments: RouteArguments(
                                                  id: state.sessionId,
                                                ),
                                              );
                                              return;
                                            }

                                            await _cubit.goNext();
                                          },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
