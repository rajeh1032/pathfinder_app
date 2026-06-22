import 'package:injectable/injectable.dart';

import '../../domain/entites/home_entity.dart';

import '../../domain/repo/home_repo.dart';
import '../data_sources/remote/home_remote_data_source.dart';

@LazySingleton(as: HomeRepository)
class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;

  HomeRepositoryImpl(this.remoteDataSource);

  @override
  Future<HomeSummaryEntity> getHomeSummary() async {
    // Fetch all data in parallel
    final results = await Future.wait([
      remoteDataSource.getCvLatest(),
      remoteDataSource.getMyRoadmap(),
      remoteDataSource.getJobMatches(),
    ]);

    final cvData = results[0] as Map<String, dynamic>?;
    final roadmapData = results[1] as Map<String, dynamic>?;
    final jobMatchesList = results[2] as List<Map<String, dynamic>>;

    // ── CV Analysis ────────────────────────────────────────
    int? cvScore;
    String? analyzedRole;
    List<String> missingSkills = [];

    if (cvData != null) {
      final analysis = cvData['analysis'] as Map<String, dynamic>?;
      if (analysis != null) {
        cvScore = analysis['score'] as int?;
        final extracted = analysis['extracted'] as Map<String, dynamic>?;
        analyzedRole = extracted?['recommended_roles'] is List
            ? (extracted!['recommended_roles'] as List).first as String?
            : null;
        missingSkills = List<String>.from(
          extracted?['missing_skills'] as List? ?? [],
        );
      }
    }

    // ── Roadmap ────────────────────────────────────────────
    HomeRoadmapEntity? roadmap;
    if (roadmapData != null) {
      roadmap = HomeRoadmapEntity.fromJson(roadmapData);
    }

    // ── Job Matches ────────────────────────────────────────
    final jobMatches = jobMatchesList
        .take(3) // show only top 3 on home
        .map((j) => HomeJobMatchEntity.fromJson(j))
        .toList();

    // ── User (from CV data or defaults) ───────────────────
    const user = HomeUserEntity(name: 'User');

    return HomeSummaryEntity(
      user: user,
      cvScore: cvScore,
      analyzedRole: analyzedRole,
      missingSkills: missingSkills,
      roadmap: roadmap,
      jobMatches: jobMatches,
    );
  }
}