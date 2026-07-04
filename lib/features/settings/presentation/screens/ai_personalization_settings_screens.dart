import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/di.dart';
import '../../../../core/storage/token_storage.dart';
import '../../data/repositories/demo_settings_repository.dart';
import '../../domain/use_cases/delete_account_use_case.dart';
import '../../domain/use_cases/get_settings_preferences_use_case.dart';
import '../../domain/use_cases/sign_out_use_case.dart';
import '../../domain/use_cases/update_career_goal_use_case.dart';
import '../../domain/use_cases/update_mentor_tone_use_case.dart';
import '../../domain/use_cases/update_settings_preference_use_case.dart';
import '../cubit/settings_cubit.dart';
import '../widgets/settings_options_view.dart';

class MentorToneSettingsScreen extends StatelessWidget {
  const MentorToneSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _createSettingsCubit()..loadSettings(),
      child: const SettingsOptionsView(
        titleKey: 'settings.mentorTone',
        sectionIcon: Icons.tune_outlined,
        currentValue: SettingsOptionValue.mentorTone,
        successKey: 'settings.mentorToneSaved',
        options: [
          SettingsOption(
            titleKey: 'settings.mentorToneProfessional',
            subtitleKey: 'settings.mentorToneProfessionalDescription',
            valueKey: 'settings.mentorToneProfessionalValue',
          ),
          SettingsOption(
            titleKey: 'settings.mentorToneTechnical',
            subtitleKey: 'settings.mentorToneTechnicalDescription',
            valueKey: 'settings.mentorToneTechnicalValue',
          ),
          SettingsOption(
            titleKey: 'settings.mentorToneFriendly',
            subtitleKey: 'settings.mentorToneFriendlyDescription',
            valueKey: 'settings.mentorToneFriendlyValue',
          ),
        ],
      ),
    );
  }
}

class CareerGoalSettingsScreen extends StatelessWidget {
  const CareerGoalSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _createSettingsCubit()..loadSettings(),
      child: const SettingsOptionsView(
        titleKey: 'settings.careerGoalTuning',
        sectionIcon: Icons.trending_up_outlined,
        currentValue: SettingsOptionValue.careerGoal,
        successKey: 'settings.careerGoalSaved',
        options: [
          SettingsOption(
            titleKey: 'settings.careerGoalFrontend',
            subtitleKey: 'settings.careerGoalFrontendDescription',
            valueKey: 'settings.careerGoalFrontendValue',
          ),
          SettingsOption(
            titleKey: 'settings.careerGoalFullStack',
            subtitleKey: 'settings.careerGoalFullStackDescription',
            valueKey: 'settings.careerGoalFullStackValue',
          ),
          SettingsOption(
            titleKey: 'settings.careerGoalProduct',
            subtitleKey: 'settings.careerGoalProductDescription',
            valueKey: 'settings.careerGoalProductValue',
          ),
        ],
      ),
    );
  }
}

SettingsCubit _createSettingsCubit() {
  final repository = DemoSettingsRepository(getIt<TokenStorage>());
  return SettingsCubit(
    getPreferencesUseCase: GetSettingsPreferencesUseCase(repository),
    updatePreferenceUseCase: UpdateSettingsPreferenceUseCase(repository),
    updateMentorToneUseCase: UpdateMentorToneUseCase(repository),
    updateCareerGoalUseCase: UpdateCareerGoalUseCase(repository),
    signOutUseCase: SignOutUseCase(repository),
    deleteAccountUseCase: DeleteAccountUseCase(repository),
  );
}
