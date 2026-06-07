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
      child: BlocBuilder<RootCubit, RootState>(
        builder: (context, state) {
          return Scaffold(
            body: IndexedStack(
              index: state.selectedIndex,
              children: const [
                HomeScreen(),
                JobMatchingScreen(),
                RoadmapsScreen(),
                InterviewStartScreen(),
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
