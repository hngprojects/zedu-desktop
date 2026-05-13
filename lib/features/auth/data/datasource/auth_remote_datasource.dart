import 'package:zedu/core/core.dart';
import 'package:zedu/features/auth/data/models/login_response_model.dart';
import 'package:zedu/features/auth/data/models/user_model.dart';

abstract interface class AuthRemoteDataSource {
  Future<LoginResponseModel> login({
    required String email,
    required String password,
  });
  Future<UserModel> me();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  const AuthRemoteDataSourceImpl({
    required AppConfig config,
    required ApiBaseService apiBaseService,
  }) : _config = config,
       _apiBaseService = apiBaseService;

  final AppConfig _config;
  final ApiBaseService _apiBaseService;

  static const _tag = 'AuthRemoteDataSource';

  @override
  Future<LoginResponseModel> login({
    required String email,
    required String password,
  }) async {
    try {
      if (_config.usesMockData) {
        AppLogger.d('Using mock data for POST /auth/login', tag: _tag);
        return LoginResponseModel.fromJson(
          LoginResponseModel.mockLoginResponse,
        );
      }

      AppLogger.d('POST /auth/login — $email', tag: _tag);
      final response = await _apiBaseService.post<Map<String, dynamic>>(
        path: '/auth/login',
        data: {'email': email, 'password': password},
      );

      final payload = response.data['data'] as Map<String, dynamic>;
      return LoginResponseModel.fromJson(payload);
    } on ApiFailure {
      rethrow;
    } catch (error) {
      AppLogger.e(
        'Failed to parse /auth/login response',
        tag: _tag,
        error: error,
      );
      throw ApiFailure.fromParsingError(error, path: '/auth/login');
    }
  }

  @override
  Future<UserModel> me() async {
    try {
      if (_config.usesMockData) {
        AppLogger.d('Using mock data for GET /users/me', tag: _tag);
        final loginResponse = LoginResponseModel.fromJson(
          LoginResponseModel.mockLoginResponse,
        );
        return loginResponse.user;
      }

      AppLogger.d('GET /users/me', tag: _tag);
      final response = await _apiBaseService.get<Map<String, dynamic>>(
        path: '/users/me',
      );

      final data = response.data['data'] as Map<String, dynamic>;
      return UserModel.fromJson(data['user'] as Map<String, dynamic>);
    } on ApiFailure {
      rethrow;
    } catch (error) {
      AppLogger.e(
        'Failed to parse /users/me response',
        tag: _tag,
        error: error,
      );
      throw ApiFailure.fromParsingError(error, path: '/users/me');
    }
  }
}
