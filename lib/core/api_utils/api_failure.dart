// core/network/api_failure.dart
import 'package:zedu/core/core.dart';

class ApiFailure implements Exception {
  const ApiFailure({
    required this.message,
    this.statusCode,
    this.path,
    this.kind = ApiFailureKind.unknown,
  });

  factory ApiFailure.fromDioException(DioException error) {
    return ApiFailure(
      message: _resolveMessage(error),
      statusCode: error.response?.statusCode,
      path: error.requestOptions.path,
      kind: _kindFromDio(error),
    );
  }

  factory ApiFailure.fromParsingError(Object error, {String? path}) {
    return ApiFailure(
      message: 'Could not parse response: $error',
      path: path,
      kind: ApiFailureKind.parsing,
    );
  }

  factory ApiFailure.unknown(Object error) {
    return ApiFailure(message: error.toString(), kind: ApiFailureKind.unknown);
  }

  final String message;
  final int? statusCode;
  final String? path;
  final ApiFailureKind kind;

  String get friendlyMessage => switch (kind) {
    ApiFailureKind.network =>
      'No internet connection. Check your network and try again.',
    ApiFailureKind.timeout => 'The request timed out. Please try again.',
    ApiFailureKind.unauthorized =>
      'Your session has expired. Please log in again.',
    ApiFailureKind.forbidden => 'You don\'t have permission to do that.',
    ApiFailureKind.notFound => 'The resource was not found.',
    ApiFailureKind.server =>
      'Something went wrong on our end. Please try again later.',
    ApiFailureKind.parsing => 'Something went wrong. Please try again.',
    ApiFailureKind.unknown => 'Something went wrong. Please try again.',
    // 4xx client errors carry a structured server message safe to show (e.g. "Invalid credentials")
    ApiFailureKind.client => message,
  };

  @override
  String toString() => message;

  static String _resolveMessage(DioException error) {
    final data = error.response?.data;
    if (data case {'message': final String message}) return message;
    if (error.message case final message?) return message;
    return 'Request failed.';
  }

  static ApiFailureKind _kindFromDio(DioException error) {
    return switch (error.type) {
      DioExceptionType.connectionTimeout ||
      DioExceptionType.sendTimeout ||
      DioExceptionType.receiveTimeout => ApiFailureKind.timeout,
      DioExceptionType.connectionError => ApiFailureKind.network,
      DioExceptionType.badResponse => switch (error.response?.statusCode) {
        401 => ApiFailureKind.unauthorized,
        403 => ApiFailureKind.forbidden,
        404 => ApiFailureKind.notFound,
        final code? when code >= 500 => ApiFailureKind.server,
        _ => ApiFailureKind.client,
      },
      _ => ApiFailureKind.unknown,
    };
  }
}

enum ApiFailureKind {
  network,
  timeout,
  unauthorized,
  forbidden,
  notFound,
  client, // 4xx other than the named ones
  server, // 5xx
  parsing, // response shape didn't match
  unknown,
}
