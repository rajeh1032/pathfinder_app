import '../../domain/entities/user_profile.dart';

class UserProfileModel {
  const UserProfileModel({
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
  final String? createdAt;
  final String? updatedAt;

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      id: json['id'] as String? ?? '',
      userId: json['user_id'] as String? ?? '',
      name: json['name'] as String?,
      educationLevelId: json['education_level_id'] as String?,
      university: json['university'] as String?,
      major: json['major'] as String?,
      currentStatusId: json['current_status_id'] as String?,
      experienceYearId: json['experience_year_id'] as String?,
      targetCareerId: json['target_career_id'] as String?,
      location: json['location'] as String?,
      headline: json['headline'] as String?,
      bio: json['bio'] as String?,
      avatarUrl: json['avatar_url'] as String?,
      avatarStoragePath: json['avatar_storage_path'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }

  UserProfile toEntity() {
    return UserProfile(
      id: id,
      userId: userId,
      name: name,
      educationLevelId: educationLevelId,
      university: university,
      major: major,
      currentStatusId: currentStatusId,
      experienceYearId: experienceYearId,
      targetCareerId: targetCareerId,
      location: location,
      headline: headline,
      bio: bio,
      avatarUrl: avatarUrl,
      avatarStoragePath: avatarStoragePath,
      createdAt: createdAt != null ? DateTime.tryParse(createdAt!) : null,
      updatedAt: updatedAt != null ? DateTime.tryParse(updatedAt!) : null,
    );
  }
}
