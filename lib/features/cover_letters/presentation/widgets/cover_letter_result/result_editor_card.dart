import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_radius.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../cover_letter/generated_draft_card.dart';
import '../cover_letter/shared_widgets.dart';

class ResultEditorCard extends StatelessWidget {
  const ResultEditorCard({
    super.key,
    required this.controller,
    required this.isEditing,
    required this.onEditModeChanged,
    required this.onCopy,
    required this.onRegenerate,
  });

  final TextEditingController controller;
  final bool isEditing;
  final ValueChanged<bool> onEditModeChanged;
  final VoidCallback onCopy;
  final VoidCallback onRegenerate;

  @override
  Widget build(BuildContext context) {
    return SurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ModeSwitch(
            isEditing: isEditing,
            onEditModeChanged: onEditModeChanged,
          ),
          SizedBox(height: AppSpacing.md.h),
          Text(
            'coverLetter.result.letterTitle'.tr(),
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.w900,
                ),
          ),
          SizedBox(height: AppSpacing.sm.h),
          if (isEditing)
            TextFormField(
              controller: controller,
              minLines: 8,
              maxLines: 12,
              decoration: const InputDecoration(border: OutlineInputBorder()),
            )
          else
            _LetterPreview(text: controller.text),
          SizedBox(height: AppSpacing.sm.h),
          Row(
            children: [
              DraftAction(
                icon: Icons.copy_outlined,
                labelKey: 'coverLetter.draft.copy',
                onPressed: onCopy,
              ),
              DraftAction(
                icon: Icons.replay_outlined,
                labelKey: 'coverLetter.draft.regenerate',
                onPressed: onRegenerate,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ModeSwitch extends StatelessWidget {
  const _ModeSwitch({
    required this.isEditing,
    required this.onEditModeChanged,
  });

  final bool isEditing;
  final ValueChanged<bool> onEditModeChanged;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Row(
      children: [
        Expanded(
          child: _ModePill(
            labelKey: 'coverLetter.result.editMode',
            selected: isEditing,
            onTap: () => onEditModeChanged(true),
          ),
        ),
        SizedBox(width: AppSpacing.sm.w),
        Expanded(
          child: _ModePill(
            labelKey: 'coverLetter.result.previewMode',
            selected: !isEditing,
            onTap: () => onEditModeChanged(false),
          ),
        ),
        SizedBox(width: AppSpacing.sm.w),
        Icon(Icons.edit_note, color: colors.primary),
      ],
    );
  }
}

class _ModePill extends StatelessWidget {
  const _ModePill({
    required this.labelKey,
    required this.onTap,
    this.selected = false,
  });

  final String labelKey;
  final VoidCallback onTap;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final color = selected ? colors.primary : colors.onSurfaceVariant;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.pill.r),
      child: Container(
        height: 44.h,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        decoration: BoxDecoration(
          color: Color.alphaBlend(
            color.withValues(alpha: selected ? .14 : .06),
            colors.surface,
          ),
          borderRadius: BorderRadius.circular(AppRadius.pill.r),
          border: Border.all(color: color.withValues(alpha: .38)),
        ),
        child: Text(
          labelKey.tr(),
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: color,
                fontWeight: FontWeight.w900,
              ),
        ),
      ),
    );
  }
}

class _LetterPreview extends StatelessWidget {
  const _LetterPreview({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSpacing.md.w),
      decoration: BoxDecoration(
        color: colors.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(AppRadius.md.r),
        border: Border.all(color: colors.outline),
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: colors.onSurface,
              height: 1.55,
              fontWeight: FontWeight.w500,
            ),
      ),
    );
  }
}
