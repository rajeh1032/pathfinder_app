import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_spacing.dart';
import '../../cubit/setup_profile_cubit.dart';
import '../../widgets/setup_profile_dropdown_field.dart';
import '../../widgets/setup_profile_step_header.dart';
import '../../widgets/setup_profile_text_field.dart';

class Step2Education extends StatefulWidget {
  const Step2Education({super.key});

  @override
  State<Step2Education> createState() => Step2EducationState();
}

// Public so SetupProfileScreen can call validate() via a GlobalKey
// before allowing the user to advance to step 3.
class Step2EducationState extends State<Step2Education> {
  final formKey = GlobalKey<FormState>();

  late final TextEditingController _universityController;
  late final TextEditingController _majorController;

  @override
  void initState() {
    super.initState();
    final s = context.read<SetupProfileCubit>().state;
    _universityController = TextEditingController(text: s.university);
    _majorController = TextEditingController(text: s.major);
  }

  @override
  void dispose() {
    _universityController.dispose();
    _majorController.dispose();
    super.dispose();
  }

  /// Called by [SetupProfileScreen] when the user taps "Continue" on step 2.
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
              title: 'profileSetup.step2Title'.tr(),
              subtitle: 'profileSetup.step2Subtitle'.tr(),
            ),
            SizedBox(height: AppSpacing.xl.h),

            // ── Degree Level ───────────────────────────────────────────────
            OnboardingDropdownField<String>(
              label: 'profileSetup.degree'.tr(),
              hintText: 'profileSetup.degreePlaceholder'.tr(),
              value: cubit.state.degreeLevel.isEmpty
                  ? null
                  : cubit.state.degreeLevel,
              prefixIcon: Icons.school_outlined,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'profileSetup.validationSelectRequired'.tr(
                    namedArgs: {'field': 'profileSetup.degree'.tr()},
                  );
                }
                return null;
              },
              items: [
                'profileSetup.degreeHighSchool'.tr(),
                'profileSetup.degreeAssociate'.tr(),
                'profileSetup.degreeBachelor'.tr(),
                'profileSetup.degreeMaster'.tr(),
                'profileSetup.degreePhd'.tr(),
                'profileSetup.degreeBootcamp'.tr(),
              ]
                  .map(
                    (option) => DropdownMenuItem<String>(
                      value: option,
                      child: Text(option),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                if (value != null) cubit.updateDegreeLevel(value);
              },
            ),
            SizedBox(height: AppSpacing.md.h),

            // ── University ────────────────────────────────────────────────
            OnboardingTextField(
              label: 'profileSetup.university'.tr(),
              placeholder: 'profileSetup.universityPlaceholder'.tr(),
              controller: _universityController,
              onChanged: cubit.updateUniversity,
              prefixIcon: Icons.account_balance_outlined,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'profileSetup.validationRequired'.tr(
                    namedArgs: {'field': 'profileSetup.university'.tr()},
                  );
                }
                return null;
              },
            ),
            SizedBox(height: AppSpacing.md.h),

            // ── Major ─────────────────────────────────────────────────────
            OnboardingTextField(
              label: 'profileSetup.major'.tr(),
              placeholder: 'profileSetup.majorPlaceholder'.tr(),
              controller: _majorController,
              onChanged: cubit.updateMajor,
              prefixIcon: Icons.menu_book_outlined,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'profileSetup.validationRequired'.tr(
                    namedArgs: {'field': 'profileSetup.major'.tr()},
                  );
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }
}
