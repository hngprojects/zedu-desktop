// data/repositories/auth_repository_impl.dart
import 'package:flutter_starter/core/core.dart';
import 'package:flutter_starter/features/features.dart';

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl({required AuthRemoteDataSource remote})
    : _remote = remote;

  final AuthRemoteDataSource _remote;

  @override
  Future<Result<User>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _remote.login(email: email, password: password);

      return Success(response.user.toEntity());
    } on ApiFailure catch (failure) {
      return Failure(failure);
    } catch (error) {
      return Failure(ApiFailure.unknown(error));
    }
  }
}
