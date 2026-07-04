import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../domain/entities/courses_query.dart';
import '../cubit/courses_catalog_state.dart';
import 'courses_filter_sheet.dart';

class CoursesCatalogHeader extends StatelessWidget {
  const CoursesCatalogHeader({
    required this.state,
    required this.onTabSelected,
    required this.onSearch,
    required this.onFilters,
    super.key,
  });

  final CoursesCatalogState state;
  final ValueChanged<CoursesCatalogTab> onTabSelected;
  final ValueChanged<String> onSearch;
  final ValueChanged<CoursesQuery> onFilters;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          child: SegmentedButton<CoursesCatalogTab>(
            showSelectedIcon: false,
            segments: CoursesCatalogTab.values
                .map((tab) => ButtonSegment(
                      value: tab,
                      label: Text(_tabKey(tab).tr()),
                    ))
                .toList(growable: false),
            selected: {state.tab},
            onSelectionChanged: (value) => onTabSelected(value.first),
          ),
        ),
        if (state.tab == CoursesCatalogTab.discover) ...[
          const SizedBox(height: AppSpacing.md),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    key: ValueKey(state.query.q),
                    onSubmitted: onSearch,
                    textInputAction: TextInputAction.search,
                    decoration: InputDecoration(
                      hintText: 'courses.searchHint'.tr(),
                      prefixIcon: const Icon(Icons.search),
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                IconButton.filledTonal(
                  tooltip: 'courses.filters'.tr(),
                  onPressed: () async {
                    final query = await showModalBottomSheet<CoursesQuery>(
                      context: context,
                      isScrollControlled: true,
                      builder: (_) => CoursesFilterSheet(query: state.query),
                    );
                    if (query != null) onFilters(query);
                  },
                  icon: const Icon(Icons.tune),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  String _tabKey(CoursesCatalogTab tab) => switch (tab) {
        CoursesCatalogTab.discover => 'courses.tabs.discover',
        CoursesCatalogTab.recommended => 'courses.tabs.recommended',
        CoursesCatalogTab.saved => 'courses.tabs.saved',
        CoursesCatalogTab.learning => 'courses.tabs.learning',
      };
}
