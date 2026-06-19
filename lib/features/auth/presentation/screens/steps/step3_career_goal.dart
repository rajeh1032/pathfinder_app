import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pathfinder_app/features/auth/presentation/widgets/setup_profile_step_header.dart';
import 'package:pathfinder_app/features/auth/presentation/widgets/setup_profile_text_field.dart';

import '../../../../../core/theme/app_radius.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../cubit/setup_profile_cubit.dart';
import '../../cubit/setup_profile_state.dart';

class Step3CareerGoal extends StatefulWidget {
  const Step3CareerGoal({super.key});

  @override
  State<Step3CareerGoal> createState() => _Step3CareerGoalState();
}

class _Step3CareerGoalState extends State<Step3CareerGoal> {
  late final TextEditingController _jobTitleController;

  static const _statusOptionKeys = [
    'profileSetup.activelyLooking',
    'profileSetup.openToOffer',
    'profileSetup.planningShift',
    'profileSetup.student',
  ];

  @override
  void initState() {
    super.initState();
    final state = context.read<SetupProfileCubit>().state;
    _jobTitleController = TextEditingController(text: state.targetJobTitle);
  }

  @override
  void dispose() {
    _jobTitleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SetupProfileCubit>();
    final colorScheme = Theme.of(context).colorScheme;

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
                        optionKey.tr(),
                        style: AppTextStyles.labelMedium(
                          isSelected
                              ? colorScheme.onPrimary
                              : colorScheme.onSurface,
                        ).copyWith(fontWeight: FontWeight.w600),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        );
      },
    );
  }
}
