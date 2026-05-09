// data/models/user_model.dart
import 'package:flutter_starter/features/auth/domain/entities/user.dart';

class UserModel {
  const UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.fullname,
    required this.email,
    required this.phone,
    required this.username,
    required this.isVerified,
    required this.isOnboarded,
    required this.createdAt,
    required this.updatedAt,
    required this.expiresAt,
  });

  final String id;
  final String firstName;
  final String lastName;
  final String fullname;
  final String email;
  final String phone;
  final String username;
  final bool isVerified;
  final bool isOnboarded;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime expiresAt;

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      fullname: json['fullname'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      username: json['username'] as String,
      isVerified: json['is_verified'] as bool,
      isOnboarded: json['is_onboarded'] as bool,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      expiresAt: DateTime.parse(json['expires_at'] as String),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'first_name': firstName,
    'last_name': lastName,
    'fullname': fullname,
    'email': email,
    'phone': phone,
    'username': username,
    'is_verified': isVerified,
    'is_onboarded': isOnboarded,
    'created_at': createdAt.toIso8601String(),
    'updated_at': updatedAt.toIso8601String(),
    'expires_at': expiresAt.toIso8601String(),
  };

  User toEntity() => User(
    id: id,
    firstName: firstName,
    lastName: lastName,
    email: email,
    phone: phone,
    username: username,
    isVerified: isVerified,
    isOnboarded: isOnboarded,
    createdAt: createdAt,
  );
}
