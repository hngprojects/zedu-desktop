import 'package:flutter_starter/core/core.dart';
import 'package:flutter_starter/features/auth/data/models/login_response_model.dart';
import 'package:flutter_starter/features/auth/data/models/user_model.dart';

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

  @override
  Future<LoginResponseModel> login({
    required String email,
    required String password,
  }) async {
    try {
      if (_config.usesMockData) {
        return LoginResponseModel.fromJson(
          LoginResponseModel.mockLoginResponse,
        );
      }

      final response = await _apiBaseService.post<Map<String, dynamic>>(
        path: '/auth/login',
        data: {'email': email, 'password': password},
      );

      return LoginResponseModel.fromJson(response.data);
    } on ApiFailure {
      rethrow;
    } catch (error) {
      throw ApiFailure.fromParsingError(error, path: '/auth/login');
    }
  }

  @override
  Future<UserModel> me() async {
    try {
      if (_config.usesMockData) {
        final loginResponse = LoginResponseModel.fromJson(
          LoginResponseModel.mockLoginResponse,
        );
        return loginResponse.user;
      }

      final response = await _apiBaseService.get<Map<String, dynamic>>(
        path: '/auth/me',
      );

      final data = response.data['data'] as Map<String, dynamic>;
      return UserModel.fromJson(data);
    } on ApiFailure {
      rethrow;
    } catch (error) {
      throw ApiFailure.fromParsingError(error, path: '/auth/me');
    }
  }
}
