import 'package:equatable/equatable.dart';

class Profile extends Equatable {
  const Profile({
    required this.id,
    required this.fullNameKey,
    required this.headlineKey,
    required this.emailKey,
    required this.locationKey,
    required this.bioKey,
    required this.avatarAsset,
    required this.goal,
    required this.experiences,
    required this.skillGroups,
    required this.achievements,
    required this.savedCourses,
    required this.savedJobs,
    required this.educationItems,
  });

  final String id;
  final String fullNameKey;
  final String headlineKey;
  final String emailKey;
  final String locationKey;
  final String bioKey;
  final String avatarAsset;
  final ProfileGoal goal;
  final List<ProfileExperience> experiences;
  final List<ProfileSkillGroup> skillGroups;
  final List<ProfileMetric> achievements;
  final List<ProfileSavedCourse> savedCourses;
  final List<ProfileSavedJob> savedJobs;
  final List<ProfileEducationItem> educationItems;

  Profile copyWith({
    String? fullNameKey,
    String? headlineKey,
    String? emailKey,
    String? locationKey,
    String? bioKey,
    String? avatarAsset,
  }) {
    return Profile(
      id: id,
      fullNameKey: fullNameKey ?? this.fullNameKey,
      headlineKey: headlineKey ?? this.headlineKey,
      emailKey: emailKey ?? this.emailKey,
      locationKey: locationKey ?? this.locationKey,
      bioKey: bioKey ?? this.bioKey,
      avatarAsset: avatarAsset ?? this.avatarAsset,
      goal: goal,
      experiences: experiences,
      skillGroups: skillGroups,
      achievements: achievements,
      savedCourses: savedCourses,
      savedJobs: savedJobs,
      educationItems: educationItems,
    );
  }

  @override
  List<Object?> get props => [
        id,
        fullNameKey,
        headlineKey,
        emailKey,
        locationKey,
        bioKey,
        avatarAsset,
        goal,
        experiences,
        skillGroups,
        achievements,
        savedCourses,
        savedJobs,
        educationItems,
      ];
}

class ProfileGoal extends Equatable {
  const ProfileGoal({
    required this.titleKey,
    required this.progress,
    required this.progressLabelKey,
    required this.completedSkillKeys,
    required this.pendingSkillKeys,
  });

  final String titleKey;
  final double progress;
  final String progressLabelKey;
  final List<String> completedSkillKeys;
  final List<String> pendingSkillKeys;

  @override
  List<Object?> get props => [
        titleKey,
        progress,
        progressLabelKey,
        completedSkillKeys,
        pendingSkillKeys,
      ];
}

class ProfileExperience extends Equatable {
  const ProfileExperience({
    required this.roleKey,
    required this.companyKey,
    required this.periodKey,
    required this.impactKeys,
  });

  final String roleKey;
  final String companyKey;
  final String periodKey;
  final List<String> impactKeys;

  @override
  List<Object?> get props => [roleKey, companyKey, periodKey, impactKeys];
}

class ProfileSkillGroup extends Equatable {
  const ProfileSkillGroup({
    required this.titleKey,
    required this.skillKeys,
  });

  final String titleKey;
  final List<String> skillKeys;

  @override
  List<Object?> get props => [titleKey, skillKeys];
}

class ProfileMetric extends Equatable {
  const ProfileMetric({
    required this.iconName,
    required this.valueKey,
    required this.labelKey,
  });

  final String iconName;
  final String valueKey;
  final String labelKey;

  @override
  List<Object?> get props => [iconName, valueKey, labelKey];
}

class ProfileSavedCourse extends Equatable {
  const ProfileSavedCourse({
    required this.id,
    required this.titleKey,
    required this.providerKey,
    required this.imageAsset,
  });

  final String id;
  final String titleKey;
  final String providerKey;
  final String imageAsset;

  @override
  List<Object?> get props => [id, titleKey, providerKey, imageAsset];
}

class ProfileSavedJob extends Equatable {
  const ProfileSavedJob({
    required this.id,
    required this.titleKey,
    required this.companyKey,
    required this.modeKey,
  });

  final String id;
  final String titleKey;
  final String companyKey;
  final String modeKey;

  @override
  List<Object?> get props => [id, titleKey, companyKey, modeKey];
}

class ProfileEducationItem extends Equatable {
  const ProfileEducationItem({
    required this.titleKey,
    required this.subtitleKey,
    required this.metaKey,
    this.highlighted = false,
  });

  final String titleKey;
  final String subtitleKey;
  final String metaKey;
  final bool highlighted;

  @override
  List<Object?> get props => [titleKey, subtitleKey, metaKey, highlighted];
}
