// data/repositories/auth_repository_impl.dart
import 'dart:async';
import 'package:zedu/core/core.dart';
import 'package:zedu/features/features.dart';

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl({
    required AuthRemoteDataSource remote,
    required AuthLocalDataSource local,
  }) : _remote = remote,
       _local = local;

  final AuthRemoteDataSource _remote;
  final AuthLocalDataSource _local;

  static const _tag = 'AuthRepository';

  @override
  Future<Result<AuthSession>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _remote.login(email: email, password: password);

      AppLogger.i('Login successful — ${response.user.email}', tag: _tag);
      return Success(
        AuthSession(
          user: response.user.toEntity(),
          accessToken: response.accessToken,
          accessTokenExpiresIn: response.accessTokenExpiresIn,
        ),
      );
    } on ApiFailure catch (failure) {
      AppLogger.w('Login failed — ${failure.message}', tag: _tag);
      return Failure(failure);
    } catch (error) {
      AppLogger.e('Unexpected login error', tag: _tag, error: error);
      return Failure(ApiFailure.unknown(error));
    }
  }

  @override
  Future<Result<AuthSession>> signUp({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _remote.signUp(email: email, password: password);

      AppLogger.i('Sign up successful — ${response.user.email}', tag: _tag);
      return Success(
        AuthSession(
          user: response.user.toEntity(),
          accessToken: response.accessToken,
          accessTokenExpiresIn: response.accessTokenExpiresIn,
        ),
      );
    } on ApiFailure catch (failure) {
      AppLogger.w('Sign up failed — ${failure.message}', tag: _tag);
      return Failure(failure);
    } catch (error) {
      AppLogger.e('Unexpected sign up error', tag: _tag, error: error);
      return Failure(ApiFailure.unknown(error));
    }
  }

  @override
  Future<Result<void>> forgotPassword({required String email}) async {
    try {
      await _remote.forgotPassword(email: email);
      AppLogger.i('Forgot password successful for — $email', tag: _tag);
      return const Success(null);
    } on ApiFailure catch (failure) {
      AppLogger.w('Forgot password failed — ${failure.message}', tag: _tag);
      return Failure(failure);
    } catch (error) {
      AppLogger.e('Unexpected forgot password error', tag: _tag, error: error);
      return Failure(ApiFailure.unknown(error));
    }
  }

  @override
  Future<Result<User>> getCurrentUser() async {
    try {
      final user = await _remote.me();
      AppLogger.i('Current user fetched — ${user.email}', tag: _tag);
      return Success(user.toEntity());
    } on ApiFailure catch (failure) {
      AppLogger.w(
        'Failed to fetch current user — ${failure.message}',
        tag: _tag,
      );
      return Failure(failure);
    } catch (error) {
      AppLogger.e(
        'Unexpected error fetching current user',
        tag: _tag,
        error: error,
      );
      return Failure(ApiFailure.unknown(error));
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _remote.logout().timeout(const Duration(seconds: 5));
      AppLogger.i('Remote logout completed', tag: _tag);
    } on ApiFailure catch (failure) {
      AppLogger.w(
        'Remote logout failed — proceeding with local logout — ${failure.message}',
        tag: _tag,
      );
    } on TimeoutException {
      AppLogger.w('Remote logout timed out — proceeding with local logout', tag: _tag);
    } catch (error) {
      AppLogger.e(
        'Remote logout unexpected error — proceeding with local logout',
        tag: _tag,
        error: error,
      );
    } finally {
      await _local.clearSession();
      AppLogger.i('Local session cleared', tag: _tag);
    }
  }
}
