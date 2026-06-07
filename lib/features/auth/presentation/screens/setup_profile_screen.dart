import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pathfinder_app/core/routing/app_routes.dart';
import 'package:pathfinder_app/features/auth/presentation/widgets/login_header.dart';
import 'package:pathfinder_app/features/auth/presentation/widgets/setup_profile_bottom_nav.dart';
import 'package:pathfinder_app/features/auth/presentation/widgets/step_indicator.dart';

import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../cubit/setup_profile_cubit.dart';
import '../cubit/setup_profile_state.dart';
import 'steps/step1_basic_info.dart';
import 'steps/step2_education.dart';
import 'steps/step3_career_goal.dart';

class SetupProfileScreen extends StatefulWidget {
  const SetupProfileScreen({super.key});

  @override
  State<SetupProfileScreen> createState() => _SetupProfileScreenState();
}

class _SetupProfileScreenState extends State<SetupProfileScreen>
    with SingleTickerProviderStateMixin {
  final _pageController = PageController();

  static final _stepLabels = ['profileSetup.basicInfo'.tr(), 'profileSetup.education'.tr(), 'profileSetup.careerGoal'.tr()];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _animateToPage(int page) {
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SetupProfileCubit>(
      create: (_) => SetupProfileCubit(),
      child: BlocListener<SetupProfileCubit, SetupProfileState>(
        listener: (context, state) {
          if (state.isSuccess) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.root,
              (_) => false,
            );
          }
          if (state.isFailure && state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage!),
                backgroundColor: Theme.of(context).colorScheme.error,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                ),
              ),
            );
            context.read<SetupProfileCubit>().resetError();
          }
          // Sync page controller with cubit step
          _animateToPage(state.currentStep);
        },
        child: BlocBuilder<SetupProfileCubit, SetupProfileState>(
          builder: (context, state) {
            final colorScheme = Theme.of(context).colorScheme;
            return Scaffold(
              backgroundColor: colorScheme.surface,
              body: SafeArea(
                child: Column(
                  children: [
                    SizedBox(height: 28.h),
                    // ── Top bar ──────────────────────────────────────────
                    LoginHeader(),
                    SizedBox(height: AppSpacing.lg.h),
                    StepIndicator(
                      currentStep: state.currentStep,
                      labels: _stepLabels,
                    ),

                    // ── Page content ─────────────────────────────────────
                    Expanded(
                      child: PageView(
                        controller: _pageController,
                        physics: const NeverScrollableScrollPhysics(),
                        children: const [
                          Step1BasicInfo(),
                          Step2Education(),
                          Step3CareerGoal(),
                        ],
                      ),
                    ),

                    // ── Bottom navigation ────────────────────────────────
                    SetupProfileBottomNav(state: state),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
