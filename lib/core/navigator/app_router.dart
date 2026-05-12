import 'package:zedu/features/features.dart';
import 'package:zedu/core/core.dart';
import 'package:zedu/features/mock_success_screen.dart';

class AppRouter {
  const AppRouter._();

  static const home = '/home';
  static const login = '/login';

  static final router = GoRouter(
    initialLocation: login,
    
    routes: [
      GoRoute(path: login, builder: (context, state) => const LoginView()),
      GoRoute(path: home, builder: (context, state) => const MockHomeScreen()),
    ],
  );
}
