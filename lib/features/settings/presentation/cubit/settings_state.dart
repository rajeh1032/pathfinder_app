import 'package:equatable/equatable.dart';

import '../../domain/entities/settings_preferences.dart';

sealed class SettingsState extends Equatable {
  const SettingsState();

  @override
  List<Object?> get props => [];
}

class SettingsInitial extends SettingsState {
  const SettingsInitial();
}

class SettingsLoading extends SettingsState {
  const SettingsLoading();
}

class SettingsSuccess extends SettingsState {
  const SettingsSuccess({required this.preferences, this.isSubmitting = false});

  final SettingsPreferences preferences;
  final bool isSubmitting;

  SettingsSuccess copyWith({
    SettingsPreferences? preferences,
    bool? isSubmitting,
  }) {
    return SettingsSuccess(
      preferences: preferences ?? this.preferences,
      isSubmitting: isSubmitting ?? this.isSubmitting,
    );
  }

  @override
  List<Object?> get props => [preferences, isSubmitting];
}

class SettingsError extends SettingsState {
  const SettingsError({this.messageKey = 'common.error'});

  final String messageKey;

  @override
  List<Object?> get props => [messageKey];
}
