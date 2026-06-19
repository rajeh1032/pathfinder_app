import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

class EditProfileField extends StatelessWidget {
  const EditProfileField({
    required this.controller,
    required this.labelKey,
    this.keyboardType,
    this.minLines,
    this.maxLines = 1,
    super.key,
  });

  final TextEditingController controller;
  final String labelKey;
  final TextInputType? keyboardType;
  final int? minLines;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        minLines: minLines,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: context.tr(labelKey),
          fillColor: colors.onPrimary,
        ),
      ),
    );
  }
}

class EditProfilePhotoAction extends StatelessWidget {
  const EditProfilePhotoAction({
    required this.icon,
    required this.labelKey,
    required this.onTap,
    super.key,
  });

  final IconData icon;
  final String labelKey;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return ListTile(
      leading: Icon(icon),
      title: Text(
        context.tr(labelKey),
        style: AppTextStyles.bodyLarge(colors.onSurface),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      onTap: onTap,
    );
  }
}
