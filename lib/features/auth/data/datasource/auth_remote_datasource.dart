import 'package:zedu/core/core.dart';
import 'package:zedu/features/auth/data/models/login_response_model.dart';
import 'package:zedu/features/auth/data/models/user_model.dart';

abstract interface class AuthRemoteDataSource {
  Future<LoginResponseModel> login({
    required String email,
    required String password,
  });
  Future<LoginResponseModel> signUp({
    required String email,
    required String password,
  });
  Future<void> forgotPassword({required String email});
  Future<UserModel> me();
  Future<void> logout();
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
  Future<LoginResponseModel> signUp({
    required String email,
    required String password,
  }) async {
    try {
      if (_config.usesMockData) {
        AppLogger.d('Using mock data for POST /auth/register', tag: _tag);
        return LoginResponseModel.fromJson(
          LoginResponseModel.mockLoginResponse,
        );
      }

      AppLogger.d('POST /auth/register — $email', tag: _tag);
      final response = await _apiBaseService.post<Map<String, dynamic>>(
        path: '/auth/register',
        data: {'email': email, 'password': password},
      );

      final payload = response.data['data'] as Map<String, dynamic>;
      return LoginResponseModel.fromJson(payload);
    } on ApiFailure {
      rethrow;
    } catch (error) {
      AppLogger.e(
        'Failed to parse /auth/register response',
        tag: _tag,
        error: error,
      );
      throw ApiFailure.fromParsingError(error, path: '/auth/register');
    }
  }

  @override
  Future<void> forgotPassword({required String email}) async {
    try {
      if (_config.usesMockData) {
        AppLogger.d('Using mock data for POST /auth/forgot-password', tag: _tag);
        return;
      }

      AppLogger.d('POST /auth/forgot-password — $email', tag: _tag);
      await _apiBaseService.post<Map<String, dynamic>?>(
        path: '/auth/forgot-password',
        data: {'email': email},
      );
    } on ApiFailure {
      rethrow;
    } catch (error) {
      AppLogger.e(
        'Failed to complete POST /auth/forgot-password',
        tag: _tag,
        error: error,
      );
      throw ApiFailure.fromParsingError(error, path: '/auth/forgot-password');
    }
  }

  @override
  Future<UserModel> me() async {
    try {
      if (_config.usesMockData) {
        AppLogger.d('Using mock data for GET /auth/me', tag: _tag);
        final loginResponse = LoginResponseModel.fromJson(
          LoginResponseModel.mockLoginResponse,
        );
        return loginResponse.user;
      }

      AppLogger.d('GET /auth/me', tag: _tag);
      final response = await _apiBaseService.get<Map<String, dynamic>>(
        path: '/auth/me',
      );

      final data = response.data['data'] as Map<String, dynamic>;
      return UserModel.fromJson(data);
    } on ApiFailure {
      rethrow;
    } catch (error) {
      AppLogger.e('Failed to parse /auth/me response', tag: _tag, error: error);
      throw ApiFailure.fromParsingError(error, path: '/auth/me');
    }
  }

  @override
  Future<void> logout() async {
    try {
      if (_config.usesMockData) {
        AppLogger.d('Using mock data for POST /auth/logout', tag: _tag);
        return;
      }

      AppLogger.d('POST /auth/logout', tag: _tag);
      await _apiBaseService.post<Map<String, dynamic>?>(
        path: '/auth/logout',
        data: const <String, dynamic>{},
      );
    } on ApiFailure {
      rethrow;
    } catch (error) {
      AppLogger.e(
        'Failed to complete POST /auth/logout',
        tag: _tag,
        error: error,
      );
      throw ApiFailure.fromParsingError(error, path: '/auth/logout');
    }
  }
}
