import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_spacing.dart';

/// Labeled text field used inside the profile create/edit form sheets.
class ProfileTextField extends StatelessWidget {
  const ProfileTextField({
    required this.controller,
    required this.labelKey,
    this.validator,
    this.keyboardType,
    this.minLines,
    this.maxLines = 1,
    super.key,
  });

  final TextEditingController controller;
  final String labelKey;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final int? minLines;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: TextFormField(
        controller: controller,
        validator: validator,
        keyboardType: keyboardType,
        minLines: minLines,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: labelKey.tr(),
          filled: true,
          fillColor: colors.onPrimary,
        ),
      ),
    );
  }
}

/// Read-only field that opens a date picker and reports a 'YYYY-MM-DD' string.
class ProfileDateField extends StatelessWidget {
  const ProfileDateField({
    required this.value,
    required this.labelKey,
    required this.onChanged,
    this.validator,
    super.key,
  });

  final String? value;
  final String labelKey;
  final ValueChanged<String> onChanged;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: TextFormField(
        readOnly: true,
        validator: validator,
        controller: TextEditingController(text: value ?? ''),
        decoration: InputDecoration(
          labelText: labelKey.tr(),
          hintText: 'profile.selectDate'.tr(),
          filled: true,
          fillColor: colors.onPrimary,
          suffixIcon: const Icon(Icons.calendar_today_outlined, size: 18),
        ),
        onTap: () async {
          final now = DateTime.now();
          final initial = _parse(value) ?? now;
          final picked = await showDatePicker(
            context: context,
            initialDate: initial,
            firstDate: DateTime(1960),
            lastDate: DateTime(now.year + 10),
          );
          if (picked != null) onChanged(_format(picked));
        },
      ),
    );
  }

  static DateTime? _parse(String? value) {
    if (value == null || value.trim().isEmpty) return null;
    return DateTime.tryParse(value);
  }

  static String _format(DateTime date) {
    final m = date.month.toString().padLeft(2, '0');
    final d = date.day.toString().padLeft(2, '0');
    return '${date.year}-$m-$d';
  }
}

/// Shows a confirmation dialog before a destructive delete.
/// Returns true when the user confirms.
Future<bool> confirmProfileDelete(
  BuildContext context, {
  required String titleKey,
}) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      title: Text(titleKey.tr()),
      content: Text('profile.deleteConfirmMessage'.tr()),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(dialogContext).pop(false),
          child: Text('common.cancel'.tr()),
        ),
        TextButton(
          onPressed: () => Navigator.of(dialogContext).pop(true),
          style: TextButton.styleFrom(
            foregroundColor: Theme.of(dialogContext).colorScheme.error,
          ),
          child: Text('profile.deleteLabel'.tr()),
        ),
      ],
    ),
  );
  return result ?? false;
}

/// Edit / delete overflow menu shared by experience and education tiles.
class ProfileItemMenu extends StatelessWidget {
  const ProfileItemMenu({
    required this.onEdit,
    required this.onDelete,
    super.key,
  });

  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return PopupMenuButton<String>(
      icon: Icon(Icons.more_horiz, color: colors.onSurfaceVariant, size: 20),
      onSelected: (value) {
        if (value == 'edit') onEdit();
        if (value == 'delete') onDelete();
      },
      itemBuilder: (_) => [
        PopupMenuItem(value: 'edit', child: Text('profile.edit'.tr())),
        PopupMenuItem(value: 'delete', child: Text('profile.deleteLabel'.tr())),
      ],
    );
  }
}
