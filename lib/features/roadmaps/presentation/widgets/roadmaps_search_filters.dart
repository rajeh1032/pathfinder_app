import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/app_search_filters.dart';
import '../cubit/roadmaps_cubit.dart';
import '../cubit/roadmaps_state.dart';

class RoadmapsSearchFilters extends StatelessWidget {
  const RoadmapsSearchFilters({
    required this.query,
    required this.selectedFilter,
    super.key,
  });

  final String query;
  final RoadmapsFilter selectedFilter;

  @override
  Widget build(BuildContext context) {
    return AppSearchFilters(
      key: ValueKey(query),
      searchHintText: 'roadmaps.searchHint'.tr(),
      onSearchChanged: context.read<RoadmapsCubit>().searchRoadmaps,
      filterChips: [
        AppFilterChip(
          icon: Icons.payments_outlined,
          label: 'roadmaps.priceFilter'.tr(),
          selected: selectedFilter == RoadmapsFilter.price,
          onTap: () => context.read<RoadmapsCubit>().toggleFilter(
                RoadmapsFilter.price,
              ),
        ),
        AppFilterChip(
          icon: Icons.schedule_outlined,
          label: 'roadmaps.durationFilter'.tr(),
          selected: selectedFilter == RoadmapsFilter.duration,
          onTap: () => context.read<RoadmapsCubit>().toggleFilter(
                RoadmapsFilter.duration,
              ),
        ),
        AppFilterChip(
          icon: Icons.bar_chart,
          label: 'roadmaps.levelFilter'.tr(),
          selected: selectedFilter == RoadmapsFilter.level,
          onTap: () => context.read<RoadmapsCubit>().toggleFilter(
                RoadmapsFilter.level,
              ),
        ),
        AppFilterChip(
          icon: Icons.tune,
          label: 'roadmaps.allFilters'.tr(),
          selected: selectedFilter == RoadmapsFilter.all,
          onTap: () => context.read<RoadmapsCubit>().toggleFilter(
                RoadmapsFilter.all,
              ),
        ),
      ],
    );
  }
}
