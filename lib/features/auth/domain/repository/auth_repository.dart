// domain/repositories/auth_repository.dart
import 'package:flutter_starter/core/core.dart';
import 'package:flutter_starter/features/features.dart';

abstract interface class AuthRepository {
  Future<Result<AuthSession>> login({required String email, required String password});
  Future<Result<User>> getCurrentUser();
}
