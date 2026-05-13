import 'package:go_router/go_router.dart';

class AppRouter {
  const AppRouter._();

  static const home = '/home';
  static const login = '/login';
  static const signUp = '/signup';
  static const forgotPassword = '/forgot-password';

  static GoRouter? _router;

  static void registerRouter(GoRouter router) {
    _router = router;
  }

  static void unregisterRouter() {
    _router = null;
  }

  static void goLogin() {
    final r = _router;
    if (r == null) {
      return;
    }
    r.go(login);
  }
}
