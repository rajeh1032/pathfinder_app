import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_radius.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../career_paths/presentation/cubit/career_paths_cubit.dart';
import '../../../../career_paths/presentation/cubit/career_paths_state.dart';
import '../../cubit/setup_profile_cubit.dart';
import '../../cubit/setup_profile_state.dart';
import '../../widgets/setup_profile_dropdown_field.dart';
import '../../widgets/setup_profile_step_header.dart';

class Step3CareerGoal extends StatefulWidget {
  const Step3CareerGoal({super.key});

  @override
  State<Step3CareerGoal> createState() => Step3CareerGoalState();
}

// Public so SetupProfileScreen can call validate() via a GlobalKey.
class Step3CareerGoalState extends State<Step3CareerGoal> {
  final formKey = GlobalKey<FormState>();
  bool _showStatusError = false;

  static const _statusOptions = [
    _StatusOption('actively looking', 'profileSetup.activelyLooking'),
    _StatusOption('open to offers', 'profileSetup.openToOffer'),
    _StatusOption('open to shift', 'profileSetup.planningShift'),
    _StatusOption('student/fresh grad', 'profileSetup.student'),
  ];

  /// Called by [SetupProfileScreen] before submitting.
  bool validate() {
    final formValid = formKey.currentState?.validate() ?? false;
    final statusSelected =
        context.read<SetupProfileCubit>().state.currentStatus.isNotEmpty;

    if (!statusSelected) {
      setState(() => _showStatusError = true);
    }

    return formValid && statusSelected;
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SetupProfileCubit>();

    return _Step3Body(
      formKey: formKey,
      showStatusError: _showStatusError,
      onTargetCareerChanged: cubit.updateTargetJobTitle,
      onStatusTap: (value) {
        setState(() => _showStatusError = false);
        cubit.updateCurrentStatus(value);
      },
    );
  }
}

class _StatusOption {
  const _StatusOption(this.value, this.labelKey);

  final String value;
  final String labelKey;
}

class _Step3Body extends StatelessWidget {
  const _Step3Body({
    required this.formKey,
    required this.showStatusError,
    required this.onTargetCareerChanged,
    required this.onStatusTap,
  });

  final GlobalKey<FormState> formKey;
  final bool showStatusError;
  final ValueChanged<String> onTargetCareerChanged;
  final void Function(String) onStatusTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return BlocBuilder<SetupProfileCubit, SetupProfileState>(
      buildWhen: (previous, current) =>
          previous.currentStatus != current.currentStatus ||
          previous.targetJobTitle != current.targetJobTitle,
      builder: (context, state) {
        return Form(
          key: formKey,
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: AppSpacing.xl.h),
                OnboardingStepHeader(
                  title: 'profileSetup.step3Title'.tr(),
                  subtitle: 'profileSetup.step3Subtitle'.tr(),
                ),
                SizedBox(height: AppSpacing.xl.h),
                BlocBuilder<CareerPathsCubit, CareerPathsState>(
                  builder: (context, pathsState) {
                    final items = pathsState.careerPaths
                        .map(
                          (path) => DropdownMenuItem<String>(
                            value: path.title,
                            child: Text(path.title),
                          ),
                        )
                        .toList();

                    final selectedValue =
                        items.any((item) => item.value == state.targetJobTitle)
                            ? state.targetJobTitle
                            : null;

                    return OnboardingDropdownField<String>(
                      label: 'profileSetup.targetJob'.tr(),
                      hintText: pathsState.isLoading
                          ? 'common.loading'.tr()
                          : 'profileSetup.targetJobPlaceholder'.tr(),
                      value: selectedValue,
                      items: items,
                      onChanged: (value) {
                        if (value != null) onTargetCareerChanged(value);
                      },
                      prefixIcon: Icons.flag_outlined,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'profileSetup.validationSelectRequired'.tr(
                            namedArgs: {
                              'field': 'profileSetup.targetJob'.tr(),
                            },
                          );
                        }
                        return null;
                      },
                    );
                  },
                ),
                BlocBuilder<CareerPathsCubit, CareerPathsState>(
                  buildWhen: (previous, current) =>
                      previous.status != current.status ||
                      previous.errorMessage != current.errorMessage,
                  builder: (context, pathsState) {
                    if (!pathsState.isFailure) return const SizedBox.shrink();

                    return Padding(
                      padding: EdgeInsets.only(top: AppSpacing.xs.h),
                      child: TextButton.icon(
                        onPressed: () =>
                            context.read<CareerPathsCubit>().load(),
                        icon: const Icon(Icons.refresh_rounded, size: 16),
                        label: Text('common.retry'.tr()),
                      ),
                    );
                  },
                ),
                SizedBox(height: AppSpacing.lg.h),
                Text(
                  'profileSetup.currentStatus'.tr(),
                  style: AppTextStyles.labelMedium(colorScheme.onSurfaceVariant)
                      .copyWith(fontWeight: FontWeight.w600),
                ),
                SizedBox(height: AppSpacing.sm.h),
                Wrap(
                  spacing: AppSpacing.sm.w,
                  runSpacing: AppSpacing.sm.h,
                  children: Step3CareerGoalState._statusOptions.map(
                    (option) {
                      final isSelected = state.currentStatus == option.value;
                      return GestureDetector(
                        onTap: () => onStatusTap(option.value),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: EdgeInsets.symmetric(
                            horizontal: AppSpacing.md.w,
                            vertical: AppSpacing.sm.h,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? colorScheme.primary
                                : colorScheme.surface,
                            border: Border.all(
                              color: isSelected
                                  ? colorScheme.primary
                                  : colorScheme.outline,
                              width: 1.5,
                            ),
                            borderRadius: BorderRadius.circular(AppRadius.md),
                          ),
                          child: Text(
                            option.labelKey.tr(),
                            style: AppTextStyles.labelMedium(
                              isSelected
                                  ? colorScheme.onPrimary
                                  : colorScheme.onSurface,
                            ).copyWith(fontWeight: FontWeight.w600),
                          ),
                        ),
                      );
                    },
                  ).toList(),
                ),
                if (showStatusError) ...[
                  SizedBox(height: AppSpacing.xs.h),
                  Text(
                    'profileSetup.validationSelectRequired'.tr(
                      namedArgs: {
                        'field': 'profileSetup.currentStatus'.tr(),
                      },
                    ),
                    style: AppTextStyles.bodySmall(colorScheme.error),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
