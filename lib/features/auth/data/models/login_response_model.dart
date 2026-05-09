import 'package:flutter_starter/features/features.dart';

class LoginResponseModel {
  const LoginResponseModel({
    required this.user,
    required this.accessToken,
    required this.accessTokenExpiresIn,
    required this.notificationToken,
  });

  final UserModel user;
  final String accessToken;
  final DateTime accessTokenExpiresIn;
  final String notificationToken;

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>;
    return LoginResponseModel(
      user: UserModel.fromJson(data['user'] as Map<String, dynamic>),
      accessToken: data['access_token'] as String,
      accessTokenExpiresIn: DateTime.parse(
        data['access_token_expires_in'] as String,
      ),
      notificationToken: data['notification_token'] as String,
    );
  }

  static const Map<String, dynamic> mockLoginResponse = {
    'data': {
      'user': {
        'id': 'mock-user-id',
        'first_name': 'Mock',
        'last_name': 'User',
        'fullname': 'Mock User',
        'email': '[email protected]',
        'phone': '+2348000000000',
        'username': 'mockuser',
        'is_verified': true,
        'is_onboarded': true,
        'created_at': '2026-01-01T00:00:00.000Z',
        'updated_at': '2026-01-01T00:00:00.000Z',
        'expires_at': '2099-01-01T00:00:00.000Z',
      },
      'access_token': 'mock_access_token',
      'access_token_expires_in': '2099-01-01T00:00:00.000Z',
      'notification_token': 'mock_notification_token',
    },
  };
}
