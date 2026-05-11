// domain/repositories/auth_repository.dart
import 'package:zedu/core/core.dart';
import 'package:zedu/features/features.dart';

abstract interface class AuthRepository {
  Future<Result<AuthSession>> login({
    required String email,
    required String password,
  });
  Future<Result<User>> getCurrentUser();
}
