import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/custom_button.dart';
import '../../domain/entities/education_entry.dart';
import 'profile_form_widgets.dart';

/// Opens the create/edit education form. Returns an [EducationInput] when the
/// user saves, or null when dismissed.
Future<EducationInput?> showEducationFormSheet(
  BuildContext context, {
  EducationEntry? existing,
}) {
  return showModalBottomSheet<EducationInput>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    showDragHandle: true,
    builder: (_) => _EducationForm(existing: existing),
  );
}

class _EducationForm extends StatefulWidget {
  const _EducationForm({this.existing});

  final EducationEntry? existing;

  @override
  State<_EducationForm> createState() => _EducationFormState();
}

class _EducationFormState extends State<_EducationForm> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _institution;
  late final TextEditingController _degree;
  late final TextEditingController _fieldOfStudy;
  late final TextEditingController _grade;
  late final TextEditingController _description;

  String? _startDate;
  String? _endDate;

  @override
  void initState() {
    super.initState();
    final e = widget.existing;
    _institution = TextEditingController(text: e?.institution ?? '');
    _degree = TextEditingController(text: e?.degree ?? '');
    _fieldOfStudy = TextEditingController(text: e?.fieldOfStudy ?? '');
    _grade = TextEditingController(text: e?.grade ?? '');
    _description = TextEditingController(text: e?.description ?? '');
    _startDate = e?.startDate;
    _endDate = e?.endDate;
  }

  @override
  void dispose() {
    _institution.dispose();
    _degree.dispose();
    _fieldOfStudy.dispose();
    _grade.dispose();
    _description.dispose();
    super.dispose();
  }

  String? _requiredMin2(String? v) {
    final value = v?.trim() ?? '';
    if (value.isEmpty) return 'profile.requiredField'.tr();
    if (value.length < 2) return 'profile.minTwoChars'.tr();
    return null;
  }

  String? _requiredDate(String? v) =>
      (v == null || v.trim().isEmpty) ? 'profile.requiredField'.tr() : null;

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    Navigator.of(context).pop(
      EducationInput(
        institution: _institution.text.trim(),
        degree: _degree.text.trim(),
        fieldOfStudy: _fieldOfStudy.text.trim(),
        startDate: _startDate,
        endDate: _endDate,
        grade: _grade.text.trim(),
        description: _description.text.trim(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final titleKey = widget.existing == null
        ? 'profile.addEducation'
        : 'profile.editEducationTitle';

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
                controller: _institution,
                labelKey: 'profile.institution',
                validator: _requiredMin2,
              ),
              ProfileTextField(
                controller: _degree,
                labelKey: 'profile.degree',
                validator: _requiredMin2,
              ),
              ProfileTextField(
                controller: _fieldOfStudy,
                labelKey: 'profile.fieldOfStudy',
                validator: _requiredMin2,
              ),
              ProfileDateField(
                value: _startDate,
                labelKey: 'profile.startDate',
                validator: _requiredDate,
                onChanged: (v) => setState(() => _startDate = v),
              ),
              ProfileDateField(
                value: _endDate,
                labelKey: 'profile.endDate',
                onChanged: (v) => setState(() => _endDate = v),
              ),
              ProfileTextField(
                controller: _grade,
                labelKey: 'profile.gradeLabel',
              ),
              ProfileTextField(
                controller: _description,
                labelKey: 'profile.descriptionLabel',
                minLines: 2,
                maxLines: 4,
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
