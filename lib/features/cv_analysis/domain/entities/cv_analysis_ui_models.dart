
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

enum SkillChipType { strength, weakness, missing }

class CvSkillChip {
  final String label;
  final SkillChipType type;

  const CvSkillChip({required this.label, required this.type});

  static List<CvSkillChip> strengthsFrom(List<String> strengths) {
    return strengths
        .map((s) => CvSkillChip(label: s, type: SkillChipType.strength))
        .toList();
  }

  static List<CvSkillChip> weaknessesFrom(List<String> weaknesses) {
    return weaknesses
        .map((s) => CvSkillChip(label: s, type: SkillChipType.weakness))
        .toList();
  }

  /// "Missing skills" aren't a separate backend field — they are derived
  /// from `suggestions` whose text mentions a skill gap. If your backend
  /// later adds a dedicated `missing_skills` field, swap this for it.
  static List<CvSkillChip> missingFrom(List<String> suggestions) {
    return suggestions
        .map((s) => CvSkillChip(label: s, type: SkillChipType.missing))
        .toList();
  }
}

class CvRecommendation {
  final String title;
  final String subtitle;
  final String avatarLabel;
  final Color avatarColor;

  const CvRecommendation({
    required this.title,
    required this.subtitle,
    required this.avatarLabel,
    required this.avatarColor,
  });

  /// Converts plain suggestion strings from the backend into displayable
  /// recommendation cards. Splits "Title: detail" style strings when
  /// possible, otherwise uses the whole string as the title.
  static List<CvRecommendation> fromSuggestions(List<String> suggestions) {
    const palette = [
      AppColors.primary,
      AppColors.secondary,
      AppColors.tertiary,
      AppColors.warning,
    ];

    return suggestions.asMap().entries.map((entry) {
      final index = entry.key;
      final text = entry.value;

      final parts = text.split(':');
      final title = parts.length > 1 ? parts.first.trim() : text;
      final subtitle = parts.length > 1 ? parts.sublist(1).join(':').trim() : '';

      final color = palette[index % palette.length];
      final initials = title.isNotEmpty
          ? title.trim().split(' ').take(2).map((w) => w[0]).join().toUpperCase()
          : 'AI';

      return CvRecommendation(
        title: title,
        subtitle: subtitle,
        avatarLabel: initials,
        avatarColor: color,
      );
    }).toList();
  }
}