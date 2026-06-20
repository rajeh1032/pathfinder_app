import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pathfinder_app/core/di/di.dart';
import 'package:pathfinder_app/core/routing/app_routes.dart';
import 'package:pathfinder_app/features/auth/presentation/widgets/login_header.dart';
import 'package:pathfinder_app/features/auth/presentation/widgets/setup_profile_bottom_nav.dart';
import 'package:pathfinder_app/features/auth/presentation/widgets/step_indicator.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/utils/custom_snackbar.dart';
import '../../../../features/auth/domain/use_cases/register_use_case.dart';
import '../cubit/setup_profile_cubit.dart';
import '../cubit/setup_profile_state.dart';
import 'steps/step1_basic_info.dart';
import 'steps/step2_education.dart';
import 'steps/step3_career_goal.dart';
class SetupProfileScreen extends StatefulWidget {
  /// Credentials collected on the register screen. They are forwarded to
  /// [SetupProfileCubit] so the final API call has everything it needs.
  const SetupProfileScreen({
    super.key,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

  final String email;
  final String password;
  final String confirmPassword;

  @override
  State<SetupProfileScreen> createState() => _SetupProfileScreenState();
}

class _SetupProfileScreenState extends State<SetupProfileScreen>
    with SingleTickerProviderStateMixin {
  final _pageController = PageController();
  final _step1Key = GlobalKey<Step1BasicInfoState>();
  final _step2Key = GlobalKey<Step2EducationState>();
  final _step3Key = GlobalKey<Step3CareerGoalState>();

  List<String> get _stepLabels => [
        'profileSetup.basicInfo'.tr(),
        'profileSetup.education'.tr(),
        'profileSetup.careerGoal'.tr(),
      ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _animateToPage(int page) {
    if (_pageController.hasClients) {
      _pageController.animateToPage(
        page,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    }
  }

  /// Validates the current step before allowing navigation forward.
  /// Returns true when the cubit should advance, false if validation failed.
  bool _validateCurrentStep(int currentStep) {
    if (currentStep == 0) {
      return _step1Key.currentState?.validate() ?? false;
    }
    if (currentStep == 1) {
      return _step2Key.currentState?.validate() ?? false;
    }
    if (currentStep == 2) {
      return _step3Key.currentState?.validate() ?? false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SetupProfileCubit>(
      create: (_) => SetupProfileCubit(
        getIt<RegisterUseCase>(),
        email: widget.email,
        password: widget.password,
        confirmPassword: widget.confirmPassword,
      ),
      child: BlocListener<SetupProfileCubit, SetupProfileState>(
        listener: (context, state) {
          if (state.status == SetupProfileStatus.success) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.root,
              (_) => false,
            );
          }

          if (state.status == SetupProfileStatus.failure &&
              state.errorMessage != null) {
            CustomSnackbar.showError(
              context: context,
              message: state.errorMessage!,
            );
            context.read<SetupProfileCubit>().resetError();
          }

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
                    const LoginHeader(),
                    SizedBox(height: AppSpacing.lg.h),
                    StepIndicator(
                      currentStep: state.currentStep,
                      labels: _stepLabels,
                    ),
                    Expanded(
                      child: PageView(
                        controller: _pageController,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          Step1BasicInfo(key: _step1Key),
                          Step2Education(key: _step2Key),
                          Step3CareerGoal(key: _step3Key),
                        ],
                      ),
                    ),
                    SetupProfileBottomNav(
                      state: state,
                      onNext: () {
                        if (_validateCurrentStep(state.currentStep)) {
                          if (state.isLastStep) {
                            context.read<SetupProfileCubit>().submit();
                          } else {
                            context.read<SetupProfileCubit>().nextStep();
                          }
                        }
                      },
                    ),
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
