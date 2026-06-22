import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/di.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../core/widgets/app_error_view.dart';
import '../../../courses/presentation/cubit/saved_courses_cubit.dart';
import '../../../jobs/presentation/cubit/saved_jobs_cubit.dart';
import '../../../roadmaps/presentation/cubit/roadmaps_cubit.dart';
import '../cubit/my_profile_cubit.dart';
import '../cubit/my_profile_state.dart';
import '../widgets/api_profile_body.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MyProfileCubit>(
          create: (_) => getIt<MyProfileCubit>()..load(),
        ),
        BlocProvider<SavedJobsCubit>(
          create: (_) => getIt<SavedJobsCubit>()..load(),
        ),
        BlocProvider<SavedCoursesCubit>(
          create: (_) => getIt<SavedCoursesCubit>()..load(),
        ),
        BlocProvider<RoadmapsCubit>(
          create: (_) => getIt<RoadmapsCubit>()..loadMyRoadmap(),
        ),
      ],
      child: const _ProfileView(),
    );
  }
}

class _ProfileView extends StatelessWidget {
  const _ProfileView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(context.tr('root.profile')),
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(
              context,
              AppRoutes.notifications,
            ),
            icon: const Icon(Icons.notifications_none_outlined),
          ),
          IconButton(
            onPressed: () => Navigator.pushNamed(context, AppRoutes.settings),
            icon: const Icon(Icons.settings_outlined),
          ),
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<MyProfileCubit, MyProfileState>(
          builder: (context, state) {
            if (state.isSuccess && state.profile != null) {
              return ApiProfileBody(state: state);
            }

            if (state.isFailure) {
              return AppErrorView(
                message: state.errorMessage ?? context.tr('common.error'),
                onRetry: context.read<MyProfileCubit>().load,
              );
            }

            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
