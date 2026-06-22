import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../widgets/animatited_progress_circle.dart';
import '../widgets/pro_tip_card.dart';
import '../widgets/step_dummy_model.dart';
import '../widgets/step_tile.dart';

class CvUploadLoadingScreen extends StatefulWidget {
  const CvUploadLoadingScreen({super.key});

  @override
  State<CvUploadLoadingScreen> createState() => _CvUploadLoadingScreenState();
}

class _CvUploadLoadingScreenState extends State<CvUploadLoadingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _rotationController;
  int _currentStep = 0;

  final List<LoadingStep> _steps = [
    LoadingStep(
      titleKey: 'cvLoading.uploading',
      subtitleKey: 'cvLoading.uploadingSubtitle',
      icon: Icons.upload_file_rounded,
      status: StepStatus.loading,
    ),
    LoadingStep(
      titleKey: 'cvLoading.parsing',
      subtitleKey: 'cvLoading.parsingSubtitle',
      icon: Icons.document_scanner_outlined,
      status: StepStatus.pending,
    ),
    LoadingStep(
      titleKey: 'cvLoading.analyzing',
      subtitleKey: 'cvLoading.analyzingSubtitle',
      icon: Icons.psychology_outlined,
      status: StepStatus.pending,
    ),
    LoadingStep(
      titleKey: 'cvLoading.generating',
      subtitleKey: 'cvLoading.generatingSubtitle',
      icon: Icons.auto_awesome_outlined,
      status: StepStatus.pending,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
    _startStepProgress();
  }

  void _startStepProgress() {
    Timer.periodic(const Duration(milliseconds: 900), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }

      setState(() {
        if (_currentStep < _steps.length) {
          _steps[_currentStep].status = StepStatus.done;
          _currentStep++;
          if (_currentStep < _steps.length) {
            _steps[_currentStep].status = StepStatus.loading;
          }
        }
      });

      if (_currentStep >= _steps.length) {
        timer.cancel();
        Future.delayed(const Duration(milliseconds: 500), () {
          if (mounted) {
            Navigator.pushReplacementNamed(
              context,
              AppRoutes.cvAnalysisResult,
            );
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppSpacing.lg.w,
            vertical: AppSpacing.xl.h,
          ),
          child: Column(
            children: [
              const Spacer(),
              // Animated circle
              AnimatedProgressCircle(controller: _rotationController),
              SizedBox(height: AppSpacing.xl.h),
              //Title
              Text(
                'cvLoading.title'.tr(),
                style: AppTextStyles.headlineSmall(colorScheme.onSurface)
                    .copyWith(fontSize: 22.sp),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: AppSpacing.sm.h),
              Text(
                'cvLoading.subtitle'.tr(),
                style: AppTextStyles.bodyMedium(colorScheme.onSurfaceVariant)
                    .copyWith(fontSize: 13.sp),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: AppSpacing.xl.h),
              // Steps
              ..._steps.asMap().entries.map(
                    (e) => StepTile(step: e.value),
                  ),
              const Spacer(),
              // Pro Tip
              ProTipCard(),
              SizedBox(height: AppSpacing.md.h),
            ],
          ),
        ),
      ),
    );
  }
}
