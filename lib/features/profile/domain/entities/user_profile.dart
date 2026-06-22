import 'package:equatable/equatable.dart';

/// Core profile returned by `GET /v1/profiles/me`.
/// Maps the snake_case API fields onto camelCase Dart fields.
class UserProfile extends Equatable {
  const UserProfile({
    required this.id,
    required this.userId,
    this.name,
    this.educationLevelId,
    this.university,
    this.major,
    this.currentStatusId,
    this.experienceYearId,
    this.targetCareerId,
    this.location,
    this.headline,
    this.bio,
    this.avatarUrl,
    this.avatarStoragePath,
    this.createdAt,
    this.updatedAt,
  });

  final String id;
  final String userId;

  /// User's display name, read from the related `users` table. Returned only
  /// by `GET /me` and read-only on the profile (change it via the auth module).
  final String? name;
  final String? educationLevelId;
  final String? university;
  final String? major;
  final String? currentStatusId;
  final String? experienceYearId;
  final String? targetCareerId;
  final String? location;
  final String? headline;
  final String? bio;
  final String? avatarUrl;
  final String? avatarStoragePath;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  UserProfile copyWith({
    String? name,
    String? university,
    String? major,
    String? location,
    String? headline,
    String? bio,
    String? avatarUrl,
    String? educationLevelId,
    String? currentStatusId,
    String? experienceYearId,
    String? targetCareerId,
  }) {
    return UserProfile(
      id: id,
      userId: userId,
      name: name ?? this.name,
      educationLevelId: educationLevelId ?? this.educationLevelId,
      university: university ?? this.university,
      major: major ?? this.major,
      currentStatusId: currentStatusId ?? this.currentStatusId,
      experienceYearId: experienceYearId ?? this.experienceYearId,
      targetCareerId: targetCareerId ?? this.targetCareerId,
      location: location ?? this.location,
      headline: headline ?? this.headline,
      bio: bio ?? this.bio,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      avatarStoragePath: avatarStoragePath,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        name,
        educationLevelId,
        university,
        major,
        currentStatusId,
        experienceYearId,
        targetCareerId,
        location,
        headline,
        bio,
        avatarUrl,
        avatarStoragePath,
        createdAt,
        updatedAt,
      ];
}
