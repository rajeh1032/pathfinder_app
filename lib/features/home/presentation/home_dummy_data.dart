import 'package:easy_localization/easy_localization.dart';

enum HomeTab { analyzeCv, chatWithAi }
class HomeUserModel {
  final String name;
  final int cvScore;
  final String targetRole;

  const HomeUserModel({
    required this.name,
    required this.cvScore,
    required this.targetRole,
  });
}

class HomeRecommendationModel {
  final String title;
  final String badge;
  final String badgeColor; // hex string for reference
  final String reason;

  const HomeRecommendationModel({
    required this.title,
    required this.badge,
    required this.badgeColor,
    required this.reason,
  });
}

class HomeSkillGapModel {
  final String skill;
  final SkillLevel level;

  const HomeSkillGapModel({required this.skill, required this.level});
}

enum SkillLevel { tailwind, nextJs, testing }

class HomeJobModel {
  final String company;
  final String logo; // asset path or initials fallback
  final String title;
  final String location;
  final String salaryRange;
  final bool isRemote;

  const HomeJobModel({
    required this.company,
    required this.logo,
    required this.title,
    required this.location,
    required this.salaryRange,
    required this.isRemote,
  });
}

class HomeRoadmapModel {
  final String title;
  final double progress; // 0.0 - 1.0
  final String status;

  const HomeRoadmapModel({
    required this.title,
    required this.progress,
    required this.status,
  });
}
class HomeDummyData {
  static const user = HomeUserModel(
    name: 'Ayat',
    cvScore: 75,
    targetRole: 'Frontend Developer',
  );

  static final recommendation = HomeRecommendationModel(
    title: 'Frontend Developer',
    badge: 'Match',
    badgeColor: '#6366F1',
    reason: 'home.basedOnYourStack'.tr(),
  );

  static const roadmap = HomeRoadmapModel(
    title: 'React Mastery',
    progress: 0.45,
    status: '45% Complete',
  );

  static const List<HomeSkillGapModel> skillGaps = [
    HomeSkillGapModel(skill: 'TypeScript', level: SkillLevel.tailwind),
    HomeSkillGapModel(skill: 'Next.js', level: SkillLevel.nextJs),
    HomeSkillGapModel(skill: 'Testing', level: SkillLevel.testing),
  ];

  static const List<HomeJobModel> jobs = [
    HomeJobModel(
      company: 'Vercel Inc.',
      logo: 'V',
      title: 'Senior Frontend Engineer',
      location: 'San Francisco (Remote)',
      salaryRange: '\$140k - \$180k',
      isRemote: true,
    ),
    HomeJobModel(
      company: 'Supabase',
      logo: 'S',
      title: 'Fullstack UI Engineer',
      location: 'Remote',
      salaryRange: '\$120k - \$95k',
      isRemote: true,
    ),
  ];
}