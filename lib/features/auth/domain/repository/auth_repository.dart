// domain/repositories/auth_repository.dart
import 'package:zedu/core/core.dart';
import 'package:zedu/features/features.dart';

abstract interface class AuthRepository {
  Future<Result<AuthSession>> login({
    required String email,
    required String password,
  });
  Future<Result<AuthSession>> signUp({
    required String email,
    required String password,
  });
  Future<Result<void>> forgotPassword({required String email});
  Future<Result<void>> resetPassword({
    required String email,
    required String token,
    required String newPassword,
  });
  Future<Result<User>> getCurrentUser();

  /// Attempts remote logout, then always clears local session (security-first).
  Future<void> logout();
}
