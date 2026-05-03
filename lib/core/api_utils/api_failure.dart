import 'package:flutter_starter/core/core.dart';

class ApiFailure implements Exception {
  const ApiFailure({required this.message, this.statusCode, this.path});

  factory ApiFailure.fromDioException(DioException error) {
    final response = error.response;

    return ApiFailure(
      message: _resolveMessage(error),
      statusCode: response?.statusCode,
      path: error.requestOptions.path,
    );
  }

  factory ApiFailure.fromFormatException(FormatException error) {
    return ApiFailure(message: error.message);
  }

  final String message;
  final int? statusCode;
  final String? path;

  @override
  String toString() => message;

  static String _resolveMessage(DioException error) {
    final data = error.response?.data;

    if (data case {'message': final String message}) {
      return message;
    }

    if (error.message case final message?) {
      return message;
    }

    return 'Request failed.';
  }
}
