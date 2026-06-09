import 'package:flutter/material.dart';
enum SkillChipType { strength, weakness, missing }
class CvSkillChip {
  final String label;
  final SkillChipType type;
  const CvSkillChip({required this.label, required this.type});
}

class CvChecklistItem {
  final String text;
  final bool isDone;
  const CvChecklistItem({required this.text, required this.isDone});
}

class CvRecommendationModel {
  final String title;
  final String subtitle;
  final String avatarLabel;
  final Color avatarColor;
  const CvRecommendationModel({
    required this.title,
    required this.subtitle,
    required this.avatarLabel,
    required this.avatarColor,
  });
}

class CvAnalysisDummyData {
  static const int score = 75;
  static const String analyzedRole = 'Senior Product Designer';
  static const String analyzedTime = 'Analysis completed: 3 mins ago';

  static const String aiInsight =
      'Your profile shows exceptional depth in Visual Design and Stakeholder Management. To increase your compatibility with Top-Tier tech firms, focus on quantifying your impact on business metrics.';

  static const List<CvSkillChip> strengths = [
    CvSkillChip(label: 'React Architecture', type: SkillChipType.strength),
    CvSkillChip(label: 'TypeScript', type: SkillChipType.strength),
    CvSkillChip(label: 'UI/UX TBTC', type: SkillChipType.strength),
  ];

  static const List<CvSkillChip> weaknesses = [
    CvSkillChip(label: 'Business KPIs', type: SkillChipType.weakness),
    CvSkillChip(label: 'Data Viz', type: SkillChipType.weakness),
  ];

  static const List<CvSkillChip> missingSkills = [
    CvSkillChip(label: 'React Native', type: SkillChipType.missing),
    CvSkillChip(label: 'AWS Cloud', type: SkillChipType.missing),
    CvSkillChip(label: 'GraphQL', type: SkillChipType.missing),
  ];

  static const List<CvChecklistItem> checklist = [
    CvChecklistItem(
      text: 'Add quantifiable metrics to "Experience"',
      isDone: false,
    ),
    CvChecklistItem(
      text: 'Include "React" in Technical Skills',
      isDone: false,
    ),
    CvChecklistItem(
      text: 'Restructure the executive highlight?',
      isDone: false,
    ),
  ];

  static const List<CvRecommendationModel> recommendations = [
    CvRecommendationModel(
      title: 'Agile Design Systems Course',
      subtitle: 'Recommended based on your analysis skill gaps',
      avatarLabel: 'AG',
      avatarColor: Color(0xFF6366F1),
    ),
    CvRecommendationModel(
      title: 'React Tech Lead Path',
      subtitle: 'To grow your skills as noted in the analysis area',
      avatarLabel: 'RT',
      avatarColor: Color(0xFF0F766E),
    ),
  ];
}