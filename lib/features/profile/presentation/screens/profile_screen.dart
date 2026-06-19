import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/routing/app_routes.dart';
import '../../../../core/widgets/app_error_view.dart';
import '../../data/repositories/demo_profile_repository.dart';
import '../../domain/use_cases/get_profile_use_case.dart';
import '../cubit/profile_cubit.dart';
import '../cubit/profile_state.dart';
import '../widgets/profile_body.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        const repository = DemoProfileRepository();
        return ProfileCubit(
          getProfileUseCase: const GetProfileUseCase(repository),
        )..loadProfile();
      },
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
        child: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            if (state is ProfileSuccess) {
              return ProfileBody(state: state);
            }

            if (state is ProfileEmpty) {
              return AppErrorView(
                message: context.tr('profile.empty'),
                onRetry: context.read<ProfileCubit>().loadProfile,
              );
            }

            if (state is ProfileError) {
              return AppErrorView(
                message: context.tr(state.messageKey),
                onRetry: context.read<ProfileCubit>().loadProfile,
              );
            }

            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
