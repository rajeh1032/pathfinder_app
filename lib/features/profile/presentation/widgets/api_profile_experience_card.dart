import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/custom_button.dart';
import '../../../../core/utils/custom_snackbar.dart';
import '../../domain/entities/work_experience.dart';
import '../cubit/my_profile_cubit.dart';
import 'experience_form_sheet.dart';
import 'profile_form_widgets.dart';
import 'profile_period_text.dart';
import 'profile_section_card.dart';

/// Experience list with full CRUD backed by [MyProfileCubit].
class ApiProfileExperienceCard extends StatelessWidget {
  const ApiProfileExperienceCard({required this.experiences, super.key});

  final List<WorkExperience> experiences;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return ProfileSectionCard(
      icon: Icons.work_outline,
      titleKey: 'profile.experience',
      trailing: IconButton(
        onPressed: () => _add(context),
        icon: const Icon(Icons.add_circle_outline),
        tooltip: 'profile.addExperience'.tr(),
      ),
      children: experiences.isEmpty
          ? [
              Text(
                'profile.noExperience'.tr(),
                style: AppTextStyles.bodyMedium(colors.onSurfaceVariant),
              ),
              const SizedBox(height: AppSpacing.md),
              CustomButton(
                labelKey: 'profile.addExperience',
                icon: Icons.add,
                variant: CustomButtonVariant.outline,
                onPressed: () => _add(context),
              ),
            ]
          : experiences
              .map((e) => _ExperienceTile(
                    experience: e,
                    onEdit: () => _edit(context, e),
                    onDelete: () => _delete(context, e),
                  ))
              .toList(),
    );
  }

  Future<void> _add(BuildContext context) async {
    final cubit = context.read<MyProfileCubit>();
    final input = await showExperienceFormSheet(context);
    if (input == null || !context.mounted) return;
    final ok = await cubit.addExperience(input);
    if (!context.mounted) return;
    _feedback(context, ok, 'profile.experienceSaved');
  }

  Future<void> _edit(BuildContext context, WorkExperience e) async {
    final cubit = context.read<MyProfileCubit>();
    final input = await showExperienceFormSheet(context, existing: e);
    if (input == null || !context.mounted) return;
    final ok = await cubit.editExperience(e.id, input);
    if (!context.mounted) return;
    _feedback(context, ok, 'profile.experienceSaved');
  }

  Future<void> _delete(BuildContext context, WorkExperience e) async {
    final cubit = context.read<MyProfileCubit>();
    final confirmed = await confirmProfileDelete(
      context,
      titleKey: 'profile.deleteExperienceTitle',
    );
    if (!confirmed || !context.mounted) return;
    final ok = await cubit.removeExperience(e.id);
    if (!context.mounted) return;
    _feedback(context, ok, 'profile.experienceDeleted');
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

class _ExperienceTile extends StatelessWidget {
  const _ExperienceTile({
    required this.experience,
    required this.onEdit,
    required this.onDelete,
  });

  final WorkExperience experience;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final period = formatProfilePeriod(
      startDate: experience.startDate,
      endDate: experience.endDate,
      isCurrent: experience.isCurrent,
    );
    final company = [experience.companyName, experience.employmentType]
        .where((v) => v != null && v.toString().trim().isNotEmpty)
        .join(' • ');

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  experience.jobTitle,
                  style: AppTextStyles.titleSmall(colors.onSurface),
                ),
              ),
              ProfileItemMenu(onEdit: onEdit, onDelete: onDelete),
            ],
          ),
          if (company.isNotEmpty)
            Text(company, style: AppTextStyles.bodyMedium(colors.tertiary)),
          if (period.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.sm),
            DecoratedBox(
              decoration: BoxDecoration(
                color: colors.primaryContainer,
                borderRadius: BorderRadius.circular(AppRadius.pill),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.xs,
                ),
                child: Text(
                  period,
                  style: AppTextStyles.labelSmall(colors.onSurfaceVariant),
                ),
              ),
            ),
          ],
          if (experience.description?.trim().isNotEmpty ?? false) ...[
            const SizedBox(height: AppSpacing.sm),
            Text(
              experience.description!.trim(),
              style: AppTextStyles.bodyMedium(colors.onSurfaceVariant),
            ),
          ],
          if (experience.skills.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.sm),
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.xs,
              children: experience.skills
                  .map(
                    (skill) => Chip(
                      label: Text(skill),
                      labelStyle: AppTextStyles.labelSmall(colors.onSurface),
                      visualDensity: VisualDensity.compact,
                    ),
                  )
                  .toList(),
            ),
          ],
          const Divider(height: AppSpacing.lg),
        ],
      ),
    );
  }
}
