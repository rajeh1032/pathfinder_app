import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../cubit/setup_profile_cubit.dart';
import '../cubit/setup_profile_state.dart';

class SetupProfileBottomNav extends StatelessWidget {
  final SetupProfileState state;
  const SetupProfileBottomNav({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final cubit = context.read<SetupProfileCubit>();

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.lg.w,
        vertical: AppSpacing.md.h,
      ),
      child: Row(
        children: [
          if (!state.isFirstStep)
            Expanded(
              child: OutlinedButton.icon(
                onPressed: state.isLoading ? null : cubit.previousStep,
                icon: Icon(Icons.arrow_back_rounded, size: 18.sp),
                label: const Text('onboarding.back').tr(),
                style: OutlinedButton.styleFrom(
                  foregroundColor: colorScheme.onSurface,
                  side: BorderSide(color: colorScheme.outline),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadius.md),
                  ),
                  minimumSize: Size(0, 52.h),
                ),
              ),
            ),
          if (!state.isFirstStep) SizedBox(width: AppSpacing.sm.w),
          Expanded(
            flex: state.isFirstStep ? 1 : 2,
            child: ElevatedButton.icon(
              onPressed: state.isLoading
                  ? null
                  : () {
                      if (state.isLastStep) {
                        cubit.submit();
                      } else {
                        cubit.nextStep();
                      }
                    },
              icon: state.isLoading
                  ? SizedBox(
                      width: 18.w,
                      height: 18.w,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: colorScheme.onPrimary,
                      ),
                    )
                  : Icon(Icons.arrow_forward_rounded, size: 18.sp),
              iconAlignment: IconAlignment.end,
              label: Text(
                state.isLastStep
                    ? 'profileSetup.buildMyPath'.tr()
                    : 'profileSetup.continue'.tr(),
                style: AppTextStyles.labelLarge(colorScheme.onPrimary)
                    .copyWith(fontWeight: FontWeight.w700),
              ),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(0, 52.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
