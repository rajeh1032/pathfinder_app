import 'package:equatable/equatable.dart';

class RegisterRegistrationData extends Equatable {
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

  const RegisterRegistrationData({
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

  @override
  List<Object?> get props => [
        email,
        password,
        confirmPassword,
        name,
        university,
        major,
        location,
        educationLevel,
        experienceYear,
        currentStatus,
        targetCareer,
      ];
}
