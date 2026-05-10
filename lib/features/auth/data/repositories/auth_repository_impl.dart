// data/repositories/auth_repository_impl.dart
import 'package:flutter_starter/core/core.dart';
import 'package:flutter_starter/features/features.dart';

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl({required AuthRemoteDataSource remote})
    : _remote = remote;

  final AuthRemoteDataSource _remote;

  @override
  Future<Result<AuthSession>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _remote.login(email: email, password: password);

      return Success(AuthSession(
        user: response.user.toEntity(),
        accessToken: response.accessToken,
        accessTokenExpiresIn: response.accessTokenExpiresIn,
      ));
    } on ApiFailure catch (failure) {
      return Failure(failure);
    } catch (error) {
      return Failure(ApiFailure.unknown(error));
    }
  }

  @override
  Future<Result<User>> getCurrentUser() async {
    try {
      final user = await _remote.me();
      return Success(user.toEntity());
    } on ApiFailure catch (failure) {
      return Failure(failure);
    } catch (error) {
      return Failure(ApiFailure.unknown(error));
    }
  }
}
