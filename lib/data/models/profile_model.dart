import 'package:ptit_quiz_frontend/domain/entities/profile.dart';

class ProfileModel extends Profile {
  ProfileModel({
    super.fullName,
    super.email,
    super.photoUrl,
    super.role = 'user',
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      fullName: json['fullName'],
      email: json['email'],
      photoUrl: json['photoUrl'],
      role: json['role'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'email': email,
      'photoUrl': photoUrl,
      'role': role,
    };
  }

  factory ProfileModel.fromEntity(Profile profile) {
    return ProfileModel(
      fullName: profile.fullName,
      email: profile.email,
      photoUrl: profile.photoUrl,
      role: profile.role,
    );
  }
}