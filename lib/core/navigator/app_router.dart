import 'package:flutter_starter/features/features.dart';
import 'package:flutter_starter/core/core.dart';

class AppRouter {
  const AppRouter._();

  static const home = '/';
  static const login = '/login';

  static final router = GoRouter(
    initialLocation: login,
    routes: [
      GoRoute(path: login, builder: (context, state) => const LoginView()),
      GoRoute(path: home, builder: (context, state) => const TasksView()),
    ],
  );
}
