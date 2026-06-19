import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/di.dart';
import '../../../../core/storage/token_storage.dart';
import '../../../../core/widgets/app_error_view.dart';
import '../../../../core/widgets/app_gradient_back_button.dart';
import '../../data/repositories/demo_settings_repository.dart';
import '../../domain/use_cases/delete_account_use_case.dart';
import '../../domain/use_cases/get_settings_preferences_use_case.dart';
import '../../domain/use_cases/sign_out_use_case.dart';
import '../../domain/use_cases/update_career_goal_use_case.dart';
import '../../domain/use_cases/update_mentor_tone_use_case.dart';
import '../../domain/use_cases/update_settings_preference_use_case.dart';
import '../cubit/settings_cubit.dart';
import '../cubit/settings_state.dart';
import '../widgets/settings_content.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final repository = DemoSettingsRepository(getIt<TokenStorage>());
        return SettingsCubit(
          getPreferencesUseCase: GetSettingsPreferencesUseCase(repository),
          updatePreferenceUseCase: UpdateSettingsPreferenceUseCase(repository),
          updateMentorToneUseCase: UpdateMentorToneUseCase(repository),
          updateCareerGoalUseCase: UpdateCareerGoalUseCase(repository),
          signOutUseCase: SignOutUseCase(repository),
          deleteAccountUseCase: DeleteAccountUseCase(repository),
        )..loadSettings();
      },
      child: const _SettingsView(),
    );
  }
}

class _SettingsView extends StatelessWidget {
  const _SettingsView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppGradientBackButton(),
        title: Text('settings.title'.tr()),
      ),
      body: SafeArea(
        child: BlocBuilder<SettingsCubit, SettingsState>(
          builder: (context, state) {
            if (state is SettingsSuccess) {
              return SettingsContent(
                preferences: state.preferences,
                isSubmitting: state.isSubmitting,
              );
            }

            if (state is SettingsError) {
              return AppErrorView(
                message: state.messageKey.tr(),
                onRetry: context.read<SettingsCubit>().loadSettings,
              );
            }

            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
