import 'package:zedu/features/features.dart';
import 'package:zedu/core/core.dart';

class AppRouter {
  const AppRouter._();

  static const home = '/';
  static const login = '/login';

  static final router = GoRouter(
    initialLocation: login,
    
    routes: [
      GoRoute(path: home, builder: (context, state) => const MockHomeScreen()),
      GoRoute(path: login, builder: (context, state) => const LoginView()),
    ],
  );
}
