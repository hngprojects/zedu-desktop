import 'package:zedu/core/core.dart';
import 'package:zedu/features/features.dart';

class AuthNotifier extends Notifier<AuthState> {
  late final AuthRepository _repository;
  late final SecureStorageService _storage;
  late final AuthInterceptor _interceptor;
  late final LogoutUseCase _logoutUseCase;

  bool _logoutInFlight = false;

  static const _tag = 'AuthNotifier';

  @override
  AuthState build() {
    _repository = ref.read(authRepositoryProvider);
    _logoutUseCase = ref.read(logoutUseCaseProvider);
    _storage = locator<SecureStorageService>();
    _interceptor = locator<AuthInterceptor>();

    _interceptor.onUnauthorized = () {
      AppLogger.w('Unauthorized — clearing session', tag: _tag);
      state = const AuthState(status: AuthStatus.unauthenticated);
    };
    _restoreSession();
    return const AuthState(status: AuthStatus.unknown);
  }

  Future<void> _restoreSession() async {
    AppLogger.d('Restoring session from storage', tag: _tag);
    final token = await _storage.getAccessToken();
    if (token == null) {
      AppLogger.i('No stored token — unauthenticated', tag: _tag);
      state = const AuthState(status: AuthStatus.unauthenticated);
      return;
    }

    final result = await _repository.getCurrentUser();
    switch (result) {
      case Success<User>():
        AppLogger.i('Session restored — ${result.value.email}', tag: _tag);
        state = AuthState(status: AuthStatus.authenticated, user: result.value);
      case Failure<User>():
        AppLogger.w('Session restore failed — clearing token', tag: _tag);
        await _storage.clearAll();
        state = const AuthState(status: AuthStatus.unauthenticated);
    }
  }

  Future<void> login({required String email, required String password}) async {
    AppLogger.d('Login attempt — $email', tag: _tag);
    state = state.copyWith(isLoading: true, clearError: true);

    final result = await _repository.login(email: email, password: password);
    switch (result) {
      case Success<AuthSession>():
        AppLogger.i('Login succeeded — token persisted', tag: _tag);
        await _storage.saveAccessToken(result.value.accessToken);
        state = AuthState(
          status: AuthStatus.authenticated,
          user: result.value.user,
        );
      case Failure<AuthSession>():
        AppLogger.w('Login rejected — ${result.error.message}', tag: _tag);
        state = state.copyWith(
          isLoading: false,
          error: result.error.friendlyMessage,
        );
    }
  }

  Future<void> signUp({required String email, required String password}) async {
    AppLogger.d('Sign up attempt — $email', tag: _tag);
    state = state.copyWith(isLoading: true, clearError: true);

    final result = await _repository.signUp(email: email, password: password);
    switch (result) {
      case Success<AuthSession>():
        AppLogger.i('Sign up succeeded — token persisted', tag: _tag);
        await _storage.saveAccessToken(result.value.accessToken);
        state = AuthState(
          status: AuthStatus.authenticated,
          user: result.value.user,
        );
      case Failure<AuthSession>():
        AppLogger.w('Sign up rejected — ${result.error.message}', tag: _tag);
        state = state.copyWith(
          isLoading: false,
          error: result.error.friendlyMessage,
        );
    }
  }

  Future<bool> forgotPassword({required String email}) async {
    AppLogger.d('Forgot password attempt — $email', tag: _tag);
    state = state.copyWith(isLoading: true, clearError: true);

    final result = await _repository.forgotPassword(email: email);
    switch (result) {
      case Success<void>():
        AppLogger.i('Forgot password succeeded', tag: _tag);
        state = state.copyWith(isLoading: false);
        return true;
      case Failure<void>():
        AppLogger.w('Forgot password rejected — ${result.error.message}', tag: _tag);
        state = state.copyWith(
          isLoading: false,
          error: result.error.friendlyMessage,
        );
        return false;
    }
  }

  Future<bool> resetPassword({
    required String email,
    required String token,
    required String newPassword,
  }) async {
    AppLogger.d('Reset password attempt — $email', tag: _tag);
    state = state.copyWith(isLoading: true, clearError: true);

    final result = await _repository.resetPassword(
      email: email,
      token: token,
      newPassword: newPassword,
    );
    
    switch (result) {
      case Success<void>():
        AppLogger.i('Reset password succeeded', tag: _tag);
        state = state.copyWith(isLoading: false);
        return true;
      case Failure<void>():
        AppLogger.w('Reset password rejected — ${result.error.message}', tag: _tag);
        state = state.copyWith(
          isLoading: false,
          error: result.error.friendlyMessage,
        );
        return false;
    }
  }

  Future<void> logout() async {
    if (_logoutInFlight) {
      AppLogger.d('Logout ignored — already in progress', tag: _tag);
      return;
    }
    _logoutInFlight = true;
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      await _logoutUseCase();
    } catch (error, stackTrace) {
      AppLogger.e(
        'Logout pipeline error — forcing unauthenticated state',
        tag: _tag,
        error: error,
        stackTrace: stackTrace,
      );
    } finally {
      _logoutInFlight = false;
      state = const AuthState(status: AuthStatus.unauthenticated, isLoading: false);
      AppRouter.goLogin();
    }
  }

  Future<String?> get accessToken => _storage.getAccessToken();
}
