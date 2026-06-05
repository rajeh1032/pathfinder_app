import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pathfinder_app/features/home/presentation/screens/home_screen.dart';

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
                _TabName(title: 'Jobs'),
                _TabName(title: 'Roadmaps'),
                _TabName(title: 'AI Mentor'),
                _TabName(title: 'Profile'),
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
  const _TabName({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        title,
        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w800,
              color: Theme.of(context).colorScheme.primary,
            ),
      ),
    );
  }
}
