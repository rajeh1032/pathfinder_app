
import 'dart:ui';
enum SearchTab { all, jobs, courses, skills, careerPaths }
class RecentSearchModel {
  final String query;
  const RecentSearchModel({required this.query});
}

class SuggestedResultModel {
  final String title;
  final String subtitle;
  final String? badge;
  final bool isTrending;
  final String avatarLabel;
  final Color? avatarColor;

  const SuggestedResultModel({
    required this.title,
    required this.subtitle,
    required this.avatarLabel,
    this.badge,
    this.isTrending = false,
    this.avatarColor,
  });
}

class SearchDummyData {
  static const List<RecentSearchModel> recentSearches = [
    RecentSearchModel(query: 'Senior UX Architect roles'),
    RecentSearchModel(query: 'Advanced React Design Patterns'),
    RecentSearchModel(query: 'Frontend Roadmap'),
  ];

  static const List<SuggestedResultModel> suggestions = [
    SuggestedResultModel(
      title: 'Advanced Microservices v',
      subtitle: 'Dr. Sarah Chen • ★ 4.9',
      badge: 'High Match',
      avatarLabel: 'AM',
      avatarColor: Color(0xFF6366F1),
    ),
    SuggestedResultModel(
      title: 'Senior Software Engineer',
      subtitle: 'TechFlow Inc. • Hybrid',
      badge: '94% Match',
      avatarLabel: 'SE',
      avatarColor: Color(0xFF0F766E),
    ),
    SuggestedResultModel(
      title: 'Senior Frontend Developer',
      subtitle: 'Est. 12–18 months • \$120k',
      avatarLabel: 'SF',
      avatarColor: Color(0xFFA855F7),
    ),
    SuggestedResultModel(
      title: 'Advanced React Design Patt.',
      subtitle: 'Required for 85% of roles',
      isTrending: true,
      avatarLabel: 'AR',
      avatarColor: Color(0xFFF59E0B),
    ),
  ];
}