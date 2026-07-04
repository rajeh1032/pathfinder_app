import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_spacing.dart';
import '../../cubit/setup_profile_cubit.dart';
import '../../widgets/setup_profile_dropdown_field.dart';
import '../../widgets/setup_profile_step_header.dart';
import '../../widgets/setup_profile_text_field.dart';

class Step1BasicInfo extends StatefulWidget {
  const Step1BasicInfo({super.key});

  @override
  State<Step1BasicInfo> createState() => Step1BasicInfoState();
}

// State is public so SetupProfileScreen can call validate() via a GlobalKey
// before allowing the user to advance to step 2.
class Step1BasicInfoState extends State<Step1BasicInfo> {
  final formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;
  late final TextEditingController _locationController;

  @override
  void initState() {
    super.initState();
    final s = context.read<SetupProfileCubit>().state;
    _nameController = TextEditingController(text: s.fullName);
    _locationController = TextEditingController(text: s.location);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  /// Called by [SetupProfileScreen] when the user taps "Continue" on step 1.
  bool validate() => formKey.currentState?.validate() ?? false;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SetupProfileCubit>();

    return Form(
      key: formKey,
      child: SingleChildScrollView(
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

            // ── Full Name ──────────────────────────────────────────────────
            OnboardingTextField(
              label: 'profileSetup.name'.tr(),
              placeholder: 'profileSetup.namePlaceholder'.tr(),
              controller: _nameController,
              onChanged: cubit.updateFullName,
              prefixIcon: Icons.person_outline_rounded,
              validator: (value) {
                final v = value?.trim() ?? '';
                if (v.isEmpty) {
                  return 'profileSetup.validationRequired'
                      .tr(namedArgs: {'field': 'profileSetup.name'.tr()});
                }
                if (v.length < 8) {
                  return 'profileSetup.validationMinLength'.tr(
                    namedArgs: {'field': 'profileSetup.name'.tr(), 'min': '8'},
                  );
                }
                if (v.length > 60) {
                  return 'profileSetup.validationMaxLength'.tr(
                    namedArgs: {'field': 'profileSetup.name'.tr(), 'max': '60'},
                  );
                }
                return null;
              },
            ),
            SizedBox(height: AppSpacing.md.h),

            // ── Location ───────────────────────────────────────────────────
            OnboardingTextField(
              label: 'profileSetup.location'.tr(),
              placeholder: 'profileSetup.locationPlaceholder'.tr(),
              controller: _locationController,
              onChanged: cubit.updateLocation,
              prefixIcon: Icons.location_on_outlined,
              validator: (value) {
                final v = value?.trim() ?? '';
                if (v.isEmpty) {
                  return 'profileSetup.validationRequired'
                      .tr(namedArgs: {'field': 'profileSetup.location'.tr()});
                }
                if (v.length < 8) {
                  return 'profileSetup.validationMinLength'.tr(
                    namedArgs: {
                      'field': 'profileSetup.location'.tr(),
                      'min': '8',
                    },
                  );
                }
                if (v.length > 60) {
                  return 'profileSetup.validationMaxLength'.tr(
                    namedArgs: {
                      'field': 'profileSetup.location'.tr(),
                      'max': '60',
                    },
                  );
                }
                return null;
              },
            ),
            SizedBox(height: AppSpacing.md.h),

            // ── Years of Experience ────────────────────────────────────────
            OnboardingDropdownField<String>(
              label: 'profileSetup.experience'.tr(),
              hintText: 'profileSetup.experiencePlaceholder'.tr(),
              value: cubit.state.yearsOfExperience.isEmpty
                  ? null
                  : cubit.state.yearsOfExperience,
              prefixIcon: Icons.work_outline_rounded,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'profileSetup.validationSelectRequired'.tr(
                    namedArgs: {'field': 'profileSetup.experience'.tr()},
                  );
                }
                return null;
              },
              items: [
                'profileSetup.experienceOption0_1'.tr(),
                'profileSetup.experienceOption1_2'.tr(),
                'profileSetup.experienceOption2_4'.tr(),
                'profileSetup.experienceOption4_7'.tr(),
                'profileSetup.experienceOption7_plus'.tr(),
              ]
                  .map(
                    (option) => DropdownMenuItem<String>(
                      value: option,
                      child: Text(option),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                if (value != null) cubit.updateYearsOfExperience(value);
              },
            ),
          ],
        ),
      ),
    );
  }
}
