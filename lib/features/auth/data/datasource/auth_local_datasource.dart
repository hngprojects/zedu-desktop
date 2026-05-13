import 'package:zedu/core/core.dart';

abstract interface class AuthLocalDataSource {

  Future<void> clearSession();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  const AuthLocalDataSourceImpl({required SecureStorageService storage})
    : _storage = storage;

  final SecureStorageService _storage;

  static const _tag = 'AuthLocalDataSource';

  @override
  Future<void> clearSession() async {
    try {
      await _storage.clearAll();
    } catch (error, stackTrace) {
      AppLogger.e(
        'clearSession failed — storage may still hold stale credentials',
        tag: _tag,
        error: error,
        stackTrace: stackTrace,
      );
    }
  }
}
