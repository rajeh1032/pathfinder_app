import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pathfinder_app/features/home/presentation/screens/home_screen.dart';

import '../../../interview/presentation/screens/interview_start_screen.dart';
import '../../../jobs/presentation/screens/job_matching_screen.dart';
import '../../../profile/presentation/screens/profile_screen.dart';
import '../../../roadmaps/presentation/screens/roadmaps_screen.dart';
import '../cubit/root_cubit.dart';
import '../cubit/root_state.dart';
import '../widgets/app_bottom_nav_bar.dart';

class RootScreen extends StatelessWidget {
  const RootScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RootCubit(),
      child: const _RootView(),
    );
  }
}

class _RootView extends StatefulWidget {
  const _RootView();

  @override
  State<_RootView> createState() => _RootViewState();
}

class _RootViewState extends State<_RootView> {
  final Set<int> _visitedTabs = {0};

  static const _pages = [
    HomeScreen(),
    JobMatchingScreen(),
    RoadmapsScreen(),
    InterviewStartScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RootCubit, RootState>(
      builder: (context, state) {
        return Scaffold(
          body: IndexedStack(
            index: state.selectedIndex,
            children: List.generate(
              _pages.length,
              (index) => _visitedTabs.contains(index)
                  ? _pages[index]
                  : const SizedBox.shrink(),
            ),
          ),
          bottomNavigationBar: AppBottomNavBar(
            selectedIndex: state.selectedIndex,
            onChanged: (index) {
              setState(() => _visitedTabs.add(index));
              context.read<RootCubit>().changeTab(index);
            },
          ),
        );
      },
    );
  }
}
