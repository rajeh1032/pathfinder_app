import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/custom_button.dart';
import '../../../../core/utils/custom_snackbar.dart';
import '../../domain/entities/education_entry.dart';
import '../cubit/my_profile_cubit.dart';
import 'education_form_sheet.dart';
import 'profile_form_widgets.dart';
import 'profile_period_text.dart';
import 'profile_section_card.dart';

/// Education list with full CRUD backed by [MyProfileCubit].
class ApiProfileEducationCard extends StatelessWidget {
  const ApiProfileEducationCard({required this.items, super.key});

  final List<EducationEntry> items;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return ProfileSectionCard(
      icon: Icons.school_outlined,
      titleKey: 'profile.education',
      trailing: IconButton(
        onPressed: () => _add(context),
        icon: const Icon(Icons.add_circle_outline),
        tooltip: 'profile.addEducation'.tr(),
      ),
      children: items.isEmpty
          ? [
              Text(
                'profile.noEducation'.tr(),
                style: AppTextStyles.bodyMedium(colors.onSurfaceVariant),
              ),
              const SizedBox(height: AppSpacing.md),
              CustomButton(
                labelKey: 'profile.addEducation',
                icon: Icons.add,
                variant: CustomButtonVariant.outline,
                onPressed: () => _add(context),
              ),
            ]
          : items
              .map((item) => _EducationTile(
                    item: item,
                    onEdit: () => _edit(context, item),
                    onDelete: () => _delete(context, item),
                  ))
              .toList(),
    );
  }

  Future<void> _add(BuildContext context) async {
    final cubit = context.read<MyProfileCubit>();
    final input = await showEducationFormSheet(context);
    if (input == null || !context.mounted) return;
    final ok = await cubit.addEducation(input);
    if (!context.mounted) return;
    _feedback(context, ok, 'profile.educationSaved');
  }

  Future<void> _edit(BuildContext context, EducationEntry item) async {
    final cubit = context.read<MyProfileCubit>();
    final input = await showEducationFormSheet(context, existing: item);
    if (input == null || !context.mounted) return;
    final ok = await cubit.editEducation(item.id, input);
    if (!context.mounted) return;
    _feedback(context, ok, 'profile.educationSaved');
  }

  Future<void> _delete(BuildContext context, EducationEntry item) async {
    final cubit = context.read<MyProfileCubit>();
    final confirmed = await confirmProfileDelete(
      context,
      titleKey: 'profile.deleteEducationTitle',
    );
    if (!confirmed || !context.mounted) return;
    final ok = await cubit.removeEducation(item.id);
    if (!context.mounted) return;
    _feedback(context, ok, 'profile.educationDeleted');
  }

  void _feedback(BuildContext context, bool ok, String successKey) {
    if (ok) {
      CustomSnackbar.showSuccessKey(context: context, messageKey: successKey);
    } else {
      final err = context.read<MyProfileCubit>().state.errorMessage;
      CustomSnackbar.showError(
        context: context,
        message: err ?? 'common.error'.tr(),
      );
    }
  }
}

class _EducationTile extends StatelessWidget {
  const _EducationTile({
    required this.item,
    required this.onEdit,
    required this.onDelete,
  });

  final EducationEntry item;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final subtitle = [item.degree, item.fieldOfStudy]
        .where((v) => v != null && v.trim().isNotEmpty)
        .join(' • ');
    final period = formatProfilePeriod(
      startDate: item.startDate,
      endDate: item.endDate,
      isCurrent: item.isCurrent,
    );
    final meta = [period, item.grade]
        .where((v) => v != null && v.toString().trim().isNotEmpty)
        .join(' • ');

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(color: colors.outlineVariant),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundColor: colors.primaryContainer,
                foregroundColor: colors.primary,
                child: const Icon(Icons.account_balance_outlined),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.institution,
                      style: AppTextStyles.titleSmall(colors.onSurface),
                    ),
                    if (subtitle.isNotEmpty)
                      Text(
                        subtitle,
                        style:
                            AppTextStyles.bodyMedium(colors.onSurfaceVariant),
                      ),
                    if (meta.isNotEmpty) ...[
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        meta,
                        style: AppTextStyles.labelSmall(colors.onSurfaceVariant),
                      ),
                    ],
                  ],
                ),
              ),
              ProfileItemMenu(onEdit: onEdit, onDelete: onDelete),
            ],
          ),
        ),
      ),
    );
  }
}
