import '../../domain/entities/register_data.dart';

class RegisterRegistrationModel {
  const RegisterRegistrationModel({
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.name,
    required this.university,
    required this.major,
    required this.location,
    required this.educationLevel,
    required this.experienceYear,
    required this.currentStatus,
    required this.targetCareer,
  });

  final String email;
  final String password;
  final String confirmPassword;
  final String name;
  final String university;
  final String major;
  final String location;
  final String educationLevel;
  final String experienceYear;
  final String currentStatus;
  final String targetCareer;

  factory RegisterRegistrationModel.fromJson(Map<String, dynamic> json) {
    // التعامل مع الـ Data Nesting لو الـ Backend غيّر الـ Structure فجأة (زي الـ Auth Model بتاعك)
    final data = json['data'];
    final source = data is Map<String, dynamic> ? data : json;

    return RegisterRegistrationModel(
      email: _readString(source, ['email', 'email_address']) ?? '',
      password: _readString(source, ['password', 'pass']) ?? '',
      confirmPassword:
          _readString(source, ['confirmPassword', 'confirm_password']) ?? '',
      name: _readString(source, ['name', 'fullName', 'full_name']) ?? '',
      university: _readString(source, ['university', 'college']) ?? '',
      major: _readString(source, ['major', 'specialization']) ?? '',
      location: _readString(source, ['location', 'address']) ?? '',
      educationLevel:
          _readString(source, ['educationLevel', 'education_level']) ?? '',
      experienceYear:
          _readString(source, ['experienceYear', 'experience_year']) ?? '',
      currentStatus:
          _readString(source, ['currentStatus', 'current_status']) ?? '',
      targetCareer:
          _readString(source, ['targetCareer', 'target_career']) ?? '',
    );
  }

  // ميثود تحويل الـ Model إلى Entity للالتزام بالـ Layering Rules
  RegisterRegistrationData toEntity() {
    return RegisterRegistrationData(
      email: email,
      password: password,
      confirmPassword: confirmPassword,
      name: name,
      university: university,
      major: major,
      location: location,
      educationLevel: educationLevel,
      experienceYear: experienceYear,
      currentStatus: currentStatus,
      targetCareer: targetCareer,
    );
  }

  // الـ Helper Method اللي بتدعم الـ Snake case والـ Camel case من الـ API
  static String? _readString(Map<String, dynamic> json, List<String> keys) {
    for (final key in keys) {
      final value = json[key];
      if (value is String) return value;
    }
    return null;
  }

  // ميثود toJson عشان هتحتاجها وأنت بتبعت الـ Request في الـ Data Source بـ Dio
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'confirmPassword': confirmPassword,
      'name': name,
      'university': university,
      'major': major,
      'location': location,
      'educationLevel': educationLevel,
      'experienceYear': experienceYear,
      'currentStatus': currentStatus,
      'targetCareer': targetCareer,
    };
  }
}
