import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../cubit/notifications_state.dart';

class NotificationFilterTabs extends StatelessWidget {
  const NotificationFilterTabs({
    required this.selectedFilter,
    required this.onSelected,
    super.key,
  });

  final NotificationFilter selectedFilter;
  final ValueChanged<NotificationFilter> onSelected;

  @override
  Widget build(BuildContext context) {
    const filters = NotificationFilter.values;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: filters
            .map(
              (filter) => Padding(
                padding: const EdgeInsetsDirectional.only(end: AppSpacing.sm),
                child: _FilterChip(
                  filter: filter,
                  selected: selectedFilter == filter,
                  onTap: () => onSelected(filter),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.filter,
    required this.selected,
    required this.onTap,
  });

  final NotificationFilter filter;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final background = selected ? colors.primary : colors.surface;
    final foreground = selected ? colors.onPrimary : colors.onSurfaceVariant;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.pill),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(AppRadius.pill),
          border: Border.all(
            color: selected ? colors.primary : colors.outlineVariant,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          child: Text(
            _labelKey(filter).tr(),
            style: AppTextStyles.labelMedium(foreground),
          ),
        ),
      ),
    );
  }

  String _labelKey(NotificationFilter filter) {
    return switch (filter) {
      NotificationFilter.all => 'notifications.filterAll',
      NotificationFilter.jobs => 'notifications.filterJobs',
      NotificationFilter.learning => 'notifications.filterLearning',
      NotificationFilter.roadmaps => 'notifications.filterRoadmaps',
      NotificationFilter.aiMentor => 'notifications.filterAiMentor',
    };
  }
}
