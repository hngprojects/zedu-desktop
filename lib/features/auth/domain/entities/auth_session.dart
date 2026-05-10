import 'package:flutter_starter/features/features.dart';

class AuthSession {
  const AuthSession({
    required this.user,
    required this.accessToken,
    required this.accessTokenExpiresIn,
  });

  final User user;
  final String accessToken;
  final DateTime accessTokenExpiresIn;
}
