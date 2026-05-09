// data/datasources/auth_remote_datasource.dart
import 'package:flutter_starter/core/core.dart';
import 'package:flutter_starter/features/auth/data/models/login_response_model.dart';

abstract interface class AuthRemoteDataSource {
  Future<LoginResponseModel> login({
    required String email,
    required String password,
  });
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
      // TypeError, FormatException, NoSuchMethodError, anything from fromJson
      throw ApiFailure.fromParsingError(error, path: '/auth/login');
    }
  }
}
