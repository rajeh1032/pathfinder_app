import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/di/di.dart';
import '../../../../../core/theme/app_radius.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../career_paths/presentation/cubit/career_paths_cubit.dart';
import '../../../../career_paths/presentation/cubit/career_paths_state.dart';
import '../../cubit/setup_profile_cubit.dart';
import '../../cubit/setup_profile_state.dart';
import '../../widgets/setup_profile_step_header.dart';
import '../../widgets/setup_profile_text_field.dart';

class Step3CareerGoal extends StatefulWidget {
  const Step3CareerGoal({super.key});

  @override
  State<Step3CareerGoal> createState() => Step3CareerGoalState();
}

// Public so SetupProfileScreen can call validate() via a GlobalKey.
class Step3CareerGoalState extends State<Step3CareerGoal> {
  final formKey = GlobalKey<FormState>();

  static const _statusOptionKeys = [
    'profileSetup.activelyLooking',
    'profileSetup.openToOffer',
    'profileSetup.planningShift',
    'profileSetup.student',
  ];

  static List<String> get _statusOptions => [
        'profileSetup.activelyLooking'.tr(),
        'profileSetup.openToOffer'.tr(),
        'profileSetup.planningShift'.tr(),
        'profileSetup.student'.tr(),
      ];

  /// Called by [SetupProfileScreen] before submitting.
  bool validate() {
    final formValid = formKey.currentState?.validate() ?? false;
    final cubit = context.read<SetupProfileCubit>();
    final statusSelected = cubit.state.currentStatus.isNotEmpty;

    if (!statusSelected) {
      setState(() => _showStatusError = true);
    }

    return formValid && statusSelected;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CareerPathsCubit>(
      create: (_) => getIt<CareerPathsCubit>()..load(),
      child: _Step3Body(
        formKey: formKey,
        statusOptions: _statusOptions,
        showStatusError: _showStatusError,
        onStatusTap: (option) {
          setState(() => _showStatusError = false);
          context.read<SetupProfileCubit>().updateCurrentStatus(option);
        },
      ),
    );
  }
}

class _Step3Body extends StatelessWidget {
  const _Step3Body({
    required this.formKey,
    required this.statusOptions,
    required this.showStatusError,
    required this.onStatusTap,
  });

  final GlobalKey<FormState> formKey;
  final List<String> statusOptions;
  final bool showStatusError;
  final void Function(String) onStatusTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final setupCubit = context.read<SetupProfileCubit>();

    return BlocBuilder<SetupProfileCubit, SetupProfileState>(
      buildWhen: (p, c) => p.currentStatus != c.currentStatus,
      builder: (context, state) {
        return SingleChildScrollView(
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
              OnboardingTextField(
                label: 'profileSetup.targetJob'.tr(),
                placeholder: 'profileSetup.targetJobPlaceholder'.tr(),
                controller: _jobTitleController,
                onChanged: cubit.updateTargetJobTitle,
                prefixIcon: Icons.flag_outlined,
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
                children: _statusOptionKeys.map((optionKey) {
                  final isSelected = state.currentStatus == optionKey;
                  return GestureDetector(
                    onTap: () => cubit.updateCurrentStatus(optionKey),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: EdgeInsets.symmetric(
                        horizontal: AppSpacing.md.w,
                        vertical: AppSpacing.sm.h,
                      ),
                    );
                  },
                ),

                SizedBox(height: AppSpacing.lg.h),

                // ── Current Status (chip selector) ─────────────────────────
                Text(
                  'profileSetup.currentStatus'.tr(),
                  style: AppTextStyles.labelMedium(colorScheme.onSurfaceVariant)
                      .copyWith(fontWeight: FontWeight.w600),
                ),
                SizedBox(height: AppSpacing.sm.h),
                Wrap(
                  spacing: AppSpacing.sm.w,
                  runSpacing: AppSpacing.sm.h,
                  children: statusOptions.map((option) {
                    final isSelected = setupState.currentStatus == option;
                    return GestureDetector(
                      onTap: () => onStatusTap(option),
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
                          option,
                          style: AppTextStyles.labelMedium(
                            isSelected
                                ? colorScheme.onPrimary
                                : colorScheme.onSurface,
                          ).copyWith(fontWeight: FontWeight.w600),
                        ),
                        borderRadius: BorderRadius.circular(AppRadius.md),
                      ),
                      child: Text(
                        optionKey.tr(),
                        style: AppTextStyles.labelMedium(
                          isSelected
                              ? colorScheme.onPrimary
                              : colorScheme.onSurface,
                        ).copyWith(fontWeight: FontWeight.w600),
                      ),
                    );
                  }).toList(),
                ),

                // Inline error shown when the user tries to submit
                // without selecting a status chip.
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
