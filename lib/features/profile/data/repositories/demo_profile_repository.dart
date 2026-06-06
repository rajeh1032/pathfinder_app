import 'package:dartz/dartz.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/profile.dart';
import '../../domain/repositories/profile_repository.dart';

class DemoProfileRepository implements ProfileRepository {
  const DemoProfileRepository();

  static Profile _profile = demoProfile;

  @override
  Future<Either<Failure, Profile>> getProfile() async {
    return Right(_profile);
  }

  @override
  Future<Either<Failure, Profile>> updateProfile(Profile profile) async {
    if (profile.fullNameKey.trim().isEmpty ||
        profile.emailKey.trim().isEmpty ||
        profile.headlineKey.trim().isEmpty) {
      return const Left(ValidationFailure('profile.editValidationError'));
    }

    _profile = profile;
    return Right(_profile);
  }

  @override
  Future<Either<Failure, Unit>> resetPassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    if (currentPassword.length < 6 || newPassword.length < 8) {
      return const Left(ValidationFailure('profile.passwordValidationError'));
    }

    return const Right(unit);
  }
}

const demoProfile = Profile(
  id: 'alex-jenkins',
  fullNameKey: 'profile.name',
  headlineKey: 'profile.headline',
  emailKey: 'profile.emailValue',
  locationKey: 'profile.locationValue',
  bioKey: 'profile.bio',
  avatarAsset: AppAssets.profileAlexJenkins,
  goal: ProfileGoal(
    titleKey: 'profile.goalTitle',
    progress: .65,
    progressLabelKey: 'profile.goalProgress65',
    completedSkillKeys: ['profile.goalSkillReactPatterns'],
    pendingSkillKeys: ['profile.goalSkillSystemDesign'],
  ),
  experiences: [
    ProfileExperience(
      roleKey: 'profile.experienceRole',
      companyKey: 'profile.experienceCompany',
      periodKey: 'profile.experiencePeriod',
      impactKeys: [
        'profile.experienceImpactMigration',
        'profile.experienceImpactLibrary',
        'profile.experienceImpactOptimization',
      ],
    ),
  ],
  skillGroups: [
    ProfileSkillGroup(
      titleKey: 'profile.skillsExpert',
      skillKeys: [
        'profile.skillTypeScript',
        'profile.skillReactNext',
        'profile.skillTailwind',
        'profile.skillComponentArchitecture',
      ],
    ),
    ProfileSkillGroup(
      titleKey: 'profile.skillsLearning',
      skillKeys: [
        'profile.skillGraphQl',
        'profile.skillWebAssembly',
        'profile.skillAiPrompting',
      ],
    ),
  ],
  achievements: [
    ProfileMetric(
      iconName: 'award',
      valueKey: 'profile.achievementFullStackValue',
      labelKey: 'profile.achievementFullStack',
    ),
    ProfileMetric(
      iconName: 'briefcase',
      valueKey: 'profile.achievementDesignValue',
      labelKey: 'profile.achievementDesign',
    ),
    ProfileMetric(
      iconName: 'leaf',
      valueKey: 'profile.achievementCleanerValue',
      labelKey: 'profile.achievementCleaner',
    ),
    ProfileMetric(
      iconName: 'target',
      valueKey: 'profile.achievementMentorValue',
      labelKey: 'profile.achievementMentor',
    ),
  ],
  savedCourses: [
    ProfileSavedCourse(
      id: 'advanced-react-design-patterns',
      titleKey: 'courses.reactPatternsShort',
      providerKey: 'courses.metaCertificate',
      imageAsset: AppAssets.roadmapTopPickReact,
    ),
    ProfileSavedCourse(
      id: 'system-design',
      titleKey: 'profile.savedCourseSystemDesign',
      providerKey: 'profile.savedCourseUdemy',
      imageAsset: AppAssets.roadmapTopPickSystems,
    ),
  ],
  savedJobs: [
    ProfileSavedJob(
      id: 'senior-frontend-google',
      titleKey: 'profile.savedJobSeniorFrontend',
      companyKey: 'profile.savedJobGoogle',
      modeKey: 'profile.savedJobFullTime',
    ),
    ProfileSavedJob(
      id: 'lead-ui-meta',
      titleKey: 'profile.savedJobLeadUi',
      companyKey: 'profile.savedJobMeta',
      modeKey: 'profile.savedJobRemote',
    ),
  ],
  educationItems: [
    ProfileEducationItem(
      titleKey: 'profile.educationUniversity',
      subtitleKey: 'profile.educationDegree',
      metaKey: 'profile.educationClass',
    ),
    ProfileEducationItem(
      titleKey: 'profile.educationGoogleUx',
      subtitleKey: 'profile.educationCoursera',
      metaKey: 'profile.educationCompleted',
      highlighted: true,
    ),
  ],
);
