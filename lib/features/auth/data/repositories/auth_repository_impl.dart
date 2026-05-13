// data/repositories/auth_repository_impl.dart
import 'package:zedu/core/core.dart';
import 'package:zedu/features/features.dart';

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl({required AuthRemoteDataSource remote})
    : _remote = remote;

  final AuthRemoteDataSource _remote;

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
}
