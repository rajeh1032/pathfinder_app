import 'package:flutter/material.dart';

import '../extensions/context_extensions.dart';
import '../theme/app_radius.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';

class AppSearchFilters extends StatelessWidget {
  const AppSearchFilters({
    required this.searchHintText,
    required this.filterChips,
    this.controller,
    this.onSearchChanged,
    this.onSearchSubmitted,
    this.readOnly = false,
    super.key,
  });

  final String searchHintText;
  final List<Widget> filterChips;
  final TextEditingController? controller;
  final ValueChanged<String>? onSearchChanged;
  final ValueChanged<String>? onSearchSubmitted;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Column(
      children: [
        TextField(
          controller: controller,
          readOnly: readOnly,
          onChanged: onSearchChanged,
          onSubmitted: onSearchSubmitted,
          decoration: InputDecoration(
            filled: true,
            fillColor: colors.onPrimary,
            prefixIcon: Icon(
              Icons.search,
              color: colors.onSurfaceVariant,
              size: 24,
            ),
            hintText: searchHintText,
            hintStyle: AppTextStyles.bodyLarge(colors.onSurfaceVariant),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.md,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadius.lg),
              borderSide: BorderSide(
                color: colors.outlineVariant.withValues(alpha: .6),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadius.lg),
              borderSide: BorderSide(
                color: colors.outlineVariant.withValues(alpha: .6),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadius.lg),
              borderSide: BorderSide(
                color: colors.primary.withValues(alpha: .55),
                width: 1.25,
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(children: filterChips),
        ),
      ],
    );
  }
}

class AppFilterChip extends StatelessWidget {
  const AppFilterChip({
    required this.icon,
    required this.label,
    this.selected = false,
    this.onTap,
    super.key,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final backgroundColor = selected
        ? colors.tertiaryContainer.withValues(alpha: .95)
        : colors.primaryContainer.withValues(alpha: .3);
    final foregroundColor = selected ? colors.tertiary : colors.onSurface;

    return Padding(
      padding: const EdgeInsetsDirectional.only(end: AppSpacing.sm),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.md),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(AppRadius.md),
            border: Border.all(
              color: selected
                  ? colors.tertiary.withValues(alpha: .14)
                  : colors.primary.withValues(alpha: .08),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, size: 18, color: foregroundColor),
                const SizedBox(width: AppSpacing.sm),
                Text(
                  label,
                  style: AppTextStyles.labelMedium(foregroundColor),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
