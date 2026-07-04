import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/error_messages.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/dio_error_handler.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entites/home_entity.dart';
import '../../domain/repo/home_repo.dart';
import '../data_sources/remote/home_remote_data_source.dart';
import '../models/home_models.dart';

@LazySingleton(as: HomeRepository)
class HomeRepositoryImpl implements HomeRepository {
  const HomeRepositoryImpl(this._remoteDataSource, this._networkInfo);

  final HomeRemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  @override
  Future<Either<Failure, HomeSummaryEntity>> getHomeSummary() async {
    if (!await _networkInfo.isConnected) {
      return const Left(NetworkFailure(ErrorMessages.network));
    }

    try {
      final results = await Future.wait([
        _remoteDataSource.getProfile(),
        _remoteDataSource.getLatestCvAnalysis(),
        _remoteDataSource.getMyRoadmap(),
        _remoteDataSource.getJobMatches(),
      ]);
      return Right(_toSummary(
        profile: results[0] as Map<String, dynamic>,
        cv: results[1] as Map<String, dynamic>,
        roadmap: results[2] as Map<String, dynamic>,
        matches: results[3] as List<Map<String, dynamic>>,
      ));
    } on DioException catch (error) {
      return Left(DioErrorHandler.handle(error));
    } on FormatException catch (error) {
      return Left(ServerFailure(error.message));
    } catch (_) {
      return const Left(UnknownFailure(ErrorMessages.unknown));
    }
  }

  HomeSummaryEntity _toSummary({
    required Map<String, dynamic> profile,
    required Map<String, dynamic> cv,
    required Map<String, dynamic> roadmap,
    required List<Map<String, dynamic>> matches,
  }) {
    final profileData = _nestedMap(profile, ['profile']) ?? profile;
    final user = _nestedMap(profile, ['user', 'users']) ?? profileData;
    final analysis = cv['analysis'] as Map<String, dynamic>?;
    final extracted =
        analysis?['extracted'] as Map<String, dynamic>? ?? const {};
    final roadmapJson = roadmap['roadmap'] as Map<String, dynamic>?;
    final roles = extracted['recommended_roles'] as List? ?? const [];
    final userName = _firstString([
      user['name'],
      profile['name'],
      profileData['name'],
      user['full_name'],
      profile['full_name'],
      profileData['full_name'],
      user['fullName'],
      profile['fullName'],
      profileData['fullName'],
    ]);

    return HomeSummaryEntity(
      user: HomeUserEntity(
        name: userName ?? '',
        avatarUrl: _firstString([
          profile['avatar_url'],
          profileData['avatar_url'],
          user['avatar_url'],
          profile['avatarUrl'],
          profileData['avatarUrl'],
          user['avatarUrl'],
        ]),
      ),
      cvScore: (analysis?['score'] as num?)?.round(),
      analyzedRole: roles.isEmpty ? null : roles.first.toString(),
      missingSkills: (extracted['missing_skills'] as List? ?? const [])
          .map((item) => item.toString())
          .toList(),
      roadmap: roadmapJson == null
          ? null
          : HomeRoadmapModel.fromJson(roadmapJson).toEntity(),
      jobMatches: matches
          .map(HomeJobMatchModel.fromJson)
          .map((model) => model.toEntity())
          .toList(),
    );
  }
}

Map<String, dynamic>? _nestedMap(Map<String, dynamic> json, List<String> keys) {
  for (final key in keys) {
    final value = json[key];
    if (value is Map<String, dynamic>) return value;
  }
  return null;
}

String? _firstString(List<Object?> values) {
  for (final value in values) {
    final text = value?.toString().trim();
    if (text != null && text.isNotEmpty) return text;
  }
  return null;
}
