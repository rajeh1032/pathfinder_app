import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/custom_button.dart';
import '../../domain/entities/work_experience.dart';
import 'profile_form_widgets.dart';

/// Opens the create/edit experience form. Returns a [WorkExperienceInput]
/// when the user saves, or null when dismissed.
Future<WorkExperienceInput?> showExperienceFormSheet(
  BuildContext context, {
  WorkExperience? existing,
}) {
  return showModalBottomSheet<WorkExperienceInput>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    showDragHandle: true,
    builder: (_) => _ExperienceForm(existing: existing),
  );
}

class _ExperienceForm extends StatefulWidget {
  const _ExperienceForm({this.existing});

  final WorkExperience? existing;

  @override
  State<_ExperienceForm> createState() => _ExperienceFormState();
}

class _ExperienceFormState extends State<_ExperienceForm> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _jobTitle;
  late final TextEditingController _company;
  late final TextEditingController _employmentType;
  late final TextEditingController _location;
  late final TextEditingController _description;
  late final TextEditingController _skills;

  String? _startDate;
  String? _endDate;
  bool _isCurrent = false;

  @override
  void initState() {
    super.initState();
    final e = widget.existing;
    _jobTitle = TextEditingController(text: e?.jobTitle ?? '');
    _company = TextEditingController(text: e?.companyName ?? '');
    _employmentType = TextEditingController(text: e?.employmentType ?? '');
    _location = TextEditingController(text: e?.location ?? '');
    _description = TextEditingController(text: e?.description ?? '');
    _skills = TextEditingController(text: (e?.skills ?? const []).join(', '));
    _startDate = e?.startDate;
    _endDate = e?.endDate;
    _isCurrent = e?.isCurrent ?? false;
  }

  @override
  void dispose() {
    _jobTitle.dispose();
    _company.dispose();
    _employmentType.dispose();
    _location.dispose();
    _description.dispose();
    _skills.dispose();
    super.dispose();
  }

  String? _requiredMin2(String? v) {
    final value = v?.trim() ?? '';
    if (value.isEmpty) return 'profile.requiredField'.tr();
    if (value.length < 2) return 'profile.minTwoChars'.tr();
    return null;
  }

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final skills = _skills.text
        .split(',')
        .map((s) => s.trim())
        .where((s) => s.isNotEmpty)
        .toList();

    Navigator.of(context).pop(
      WorkExperienceInput(
        jobTitle: _jobTitle.text.trim(),
        companyName: _company.text.trim(),
        employmentType: _employmentType.text.trim(),
        location: _location.text.trim(),
        startDate: _startDate,
        endDate: _isCurrent ? null : _endDate,
        isCurrent: _isCurrent,
        description: _description.text.trim(),
        skills: skills,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final titleKey = widget.existing == null
        ? 'profile.addExperience'
        : 'profile.editExperienceTitle';

    return Padding(
      padding: EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.md,
        AppSpacing.lg,
        MediaQuery.of(context).viewInsets.bottom + AppSpacing.lg,
      ),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                titleKey.tr(),
                style: AppTextStyles.titleMedium(colors.onSurface),
              ),
              const SizedBox(height: AppSpacing.md),
              ProfileTextField(
                controller: _jobTitle,
                labelKey: 'profile.jobTitle',
                validator: _requiredMin2,
              ),
              ProfileTextField(
                controller: _company,
                labelKey: 'profile.companyName',
                validator: _requiredMin2,
              ),
              ProfileTextField(
                controller: _employmentType,
                labelKey: 'profile.employmentType',
              ),
              ProfileTextField(
                controller: _location,
                labelKey: 'profile.locationLabel',
              ),
              ProfileDateField(
                value: _startDate,
                labelKey: 'profile.startDate',
                onChanged: (v) => setState(() => _startDate = v),
              ),
              if (!_isCurrent)
                ProfileDateField(
                  value: _endDate,
                  labelKey: 'profile.endDate',
                  onChanged: (v) => setState(() => _endDate = v),
                ),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                value: _isCurrent,
                title: Text(
                  'profile.currentlyWorking'.tr(),
                  style: AppTextStyles.bodyMedium(colors.onSurface),
                ),
                onChanged: (v) => setState(() => _isCurrent = v),
              ),
              ProfileTextField(
                controller: _description,
                labelKey: 'profile.descriptionLabel',
                minLines: 2,
                maxLines: 4,
              ),
              ProfileTextField(
                controller: _skills,
                labelKey: 'profile.skillsLabel',
              ),
              const SizedBox(height: AppSpacing.sm),
              CustomButton(
                labelKey: 'profile.saveLabel',
                onPressed: _submit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
