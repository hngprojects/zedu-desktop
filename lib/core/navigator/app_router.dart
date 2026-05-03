import 'package:flutter_starter/features/features.dart';
import 'package:flutter_starter/core/core.dart';

class AppRouter {
  const AppRouter._();

  static const home = '/';

  static final router = GoRouter(
    initialLocation: home,
    routes: [
      GoRoute(path: home, builder: (_, _) => const TasksView()),
    ],
  );
}
