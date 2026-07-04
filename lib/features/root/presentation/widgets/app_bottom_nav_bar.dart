import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AppBottomNavBar extends StatelessWidget {
  const AppBottomNavBar({
    required this.selectedIndex,
    required this.onChanged,
    super.key,
  });

  final int selectedIndex;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: selectedIndex,
      onDestinationSelected: onChanged,
      destinations: [
        NavigationDestination(
          icon: const Icon(Icons.home_outlined),
          selectedIcon: const Icon(Icons.home),
          label: context.tr('root.home'),
        ),
        NavigationDestination(
          icon: const Icon(Icons.work_outline),
          selectedIcon: const Icon(Icons.work),
          label: context.tr('root.jobs'),
        ),
        NavigationDestination(
          icon: const Icon(Icons.route_outlined),
          selectedIcon: const Icon(Icons.route),
          label: context.tr('root.roadmaps'),
        ),
        NavigationDestination(
          icon: const Icon(Icons.psychology_outlined),
          selectedIcon: const Icon(Icons.psychology),
          label: context.tr('root.aiMentor'),
        ),
        NavigationDestination(
          icon: const Icon(Icons.person_outline),
          selectedIcon: const Icon(Icons.person),
          label: context.tr('root.profileShort'),
        ),
      ],
    );
  }
}
