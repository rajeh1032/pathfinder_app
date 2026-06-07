import 'package:equatable/equatable.dart';

enum SettingsPreferenceKey {
  aiTrainingData,
  pushNotifications,
  emailDigests,
}

class SettingsPreferences extends Equatable {
  const SettingsPreferences({
    required this.displayNameKey,
    required this.headlineKey,
    required this.avatarAsset,
    required this.emailKey,
    required this.phoneKey,
    required this.mentorToneKey,
    required this.careerGoalKey,
    required this.aiTrainingData,
    required this.pushNotifications,
    required this.emailDigests,
  });

  final String displayNameKey;
  final String headlineKey;
  final String avatarAsset;
  final String emailKey;
  final String phoneKey;
  final String mentorToneKey;
  final String careerGoalKey;
  final bool aiTrainingData;
  final bool pushNotifications;
  final bool emailDigests;

  SettingsPreferences copyWith({
    String? mentorToneKey,
    String? careerGoalKey,
    bool? aiTrainingData,
    bool? pushNotifications,
    bool? emailDigests,
  }) {
    return SettingsPreferences(
      displayNameKey: displayNameKey,
      headlineKey: headlineKey,
      avatarAsset: avatarAsset,
      emailKey: emailKey,
      phoneKey: phoneKey,
      mentorToneKey: mentorToneKey ?? this.mentorToneKey,
      careerGoalKey: careerGoalKey ?? this.careerGoalKey,
      aiTrainingData: aiTrainingData ?? this.aiTrainingData,
      pushNotifications: pushNotifications ?? this.pushNotifications,
      emailDigests: emailDigests ?? this.emailDigests,
    );
  }

  @override
  List<Object?> get props => [
        displayNameKey,
        headlineKey,
        avatarAsset,
        emailKey,
        phoneKey,
        mentorToneKey,
        careerGoalKey,
        aiTrainingData,
        pushNotifications,
        emailDigests,
      ];
}
