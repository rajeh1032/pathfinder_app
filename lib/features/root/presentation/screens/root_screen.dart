import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pathfinder_app/features/home/presentation/screens/home_screen.dart';

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
      child: BlocBuilder<RootCubit, RootState>(
        builder: (context, state) {
          return Scaffold(
            body: IndexedStack(
              index: state.selectedIndex,
              children: const [
                _TabName(title: 'Home'),
                JobMatchingScreen(),
                HomeScreen(),
                _TabName(titleKey: 'root.jobs'),
                RoadmapsScreen(),
                _TabName(titleKey: 'root.aiMentor'),
                ProfileScreen(),
              ],
            ),
            bottomNavigationBar: AppBottomNavBar(
              selectedIndex: state.selectedIndex,
              onChanged: context.read<RootCubit>().changeTab,
            ),
          );
        },
      ),
    );
  }
}

class _TabName extends StatelessWidget {
  const _TabName({required this.titleKey});

  final String titleKey;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        titleKey.tr(),
        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w800,
              color: Theme.of(context).colorScheme.primary,
            ),
      ),
    );
  }
}
