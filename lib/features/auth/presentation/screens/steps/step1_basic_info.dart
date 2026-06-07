import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_spacing.dart';

import '../../cubit/setup_profile_cubit.dart';

import '../../widgets/setup_profile_text_field.dart';
import '../../widgets/setup_profile_step_header.dart';

class Step1BasicInfo extends StatefulWidget {
  const Step1BasicInfo({super.key});

  @override
  State<Step1BasicInfo> createState() => _Step1BasicInfoState();
}

class _Step1BasicInfoState extends State<Step1BasicInfo> {
  late final TextEditingController _nameController;
  late final TextEditingController _locationController;
  late final TextEditingController _yearsController;

  @override
  void initState() {
    super.initState();
    final state = context.read<SetupProfileCubit>().state;
    _nameController = TextEditingController(text: state.fullName);
    _locationController = TextEditingController(text: state.location);
    _yearsController = TextEditingController(text: state.yearsOfExperience);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _locationController.dispose();
    _yearsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SetupProfileCubit>();
    final colorScheme = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: AppSpacing.xl.h),
           OnboardingStepHeader(
            title: 'profileSetup.step1Title'.tr(),
            subtitle: 'profileSetup.step1Subtitle'.tr(),
          ),
          SizedBox(height: AppSpacing.xl.h),
          OnboardingTextField(
            label: 'profileSetup.name'.tr(),
            placeholder: 'profileSetup.namePlaceholder'.tr(),
            controller: _nameController,
            onChanged: cubit.updateFullName,
            prefixIcon: Icons.person_outline_rounded,
          ),
          SizedBox(height: AppSpacing.md.h),
          OnboardingTextField(
            label: 'profileSetup.location'.tr(),
            placeholder: 'profileSetup.locationPlaceholder'.tr(),
            controller: _locationController,
            onChanged: cubit.updateLocation,
            prefixIcon: Icons.location_on_outlined,
          ),
          SizedBox(height: AppSpacing.md.h),
          OnboardingTextField(
            label: 'profileSetup.experience'.tr(),
            placeholder: 'profileSetup.experiencePlaceholder'.tr(),
            controller: _yearsController,
            onChanged: cubit.updateYearsOfExperience,
            prefixIcon: Icons.work_outline_rounded,
          ),
        ],
      ),
    );
  }
}
