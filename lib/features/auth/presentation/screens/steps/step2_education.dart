import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_spacing.dart';
import '../../cubit/setup_profile_cubit.dart';
import '../../widgets/setup_profile_text_field.dart';
import '../../widgets/setup_profile_step_header.dart';

class Step2Education extends StatefulWidget {
  const Step2Education({super.key});

  @override
  State<Step2Education> createState() => _Step2EducationState();
}

class _Step2EducationState extends State<Step2Education> {
  late final TextEditingController _degreeController;
  late final TextEditingController _universityController;
  late final TextEditingController _majorController;

  @override
  void initState() {
    super.initState();
    final state = context.read<SetupProfileCubit>().state;
    _degreeController = TextEditingController(text: state.degreeLevel);
    _universityController = TextEditingController(text: state.university);
    _majorController = TextEditingController(text: state.major);
  }

  @override
  void dispose() {
    _degreeController.dispose();
    _universityController.dispose();
    _majorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SetupProfileCubit>();

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: AppSpacing.xl.h),
           OnboardingStepHeader(
            title: 'profileSetup.step2Title'.tr(),
            subtitle: 'profileSetup.step2Subtitle'.tr(),
          ),
          SizedBox(height: AppSpacing.xl.h),
          OnboardingTextField(
            label: 'profileSetup.degree'.tr(),
            placeholder: 'profileSetup.degreePlaceholder'.tr(),
            controller: _degreeController,
            onChanged: cubit.updateDegreeLevel,
            prefixIcon: Icons.school_outlined,
          ),
          SizedBox(height: AppSpacing.md.h),
          OnboardingTextField(
            label: 'profileSetup.university'.tr(),
            placeholder: 'profileSetup.universityPlaceholder'.tr(),
            controller: _universityController,
            onChanged: cubit.updateUniversity,
            prefixIcon: Icons.account_balance_outlined,
          ),
          SizedBox(height: AppSpacing.md.h),
          OnboardingTextField(
            label: 'profileSetup.major'.tr(),
            placeholder: 'profileSetup.majorPlaceholder'.tr(),
            controller: _majorController,
            onChanged: cubit.updateMajor,
            prefixIcon: Icons.menu_book_outlined,
          ),
        ],
      ),
    );
  }
}