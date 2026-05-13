import 'package:zedu/core/core.dart';
import 'package:zedu/features/features.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  final refresh = ValueNotifier<int>(0);
  ref.onDispose(refresh.dispose);
  ref.listen<AuthState>(authNotifierProvider, (_, _) {
    refresh.value++;
  });

  final router = GoRouter(
    initialLocation: AppRouter.login,
    refreshListenable: refresh,
    redirect: (context, state) {
      final auth = ref.read(authNotifierProvider);
      final loc = state.matchedLocation;

      if (auth.status == AuthStatus.unknown) {
        return null;
      }

      final onAuthScreen = loc == AppRouter.login || 
                           loc == AppRouter.signUp || 
                           loc == AppRouter.forgotPassword ||
                           loc == AppRouter.resetPassword;

      if (auth.status == AuthStatus.authenticated) {
        if (onAuthScreen) {
          return AppRouter.home;
        }
        return null;
      }

      if (!onAuthScreen) {
        return AppRouter.login;
      }
      return null;
    },
    routes: [
      GoRoute(path: AppRouter.login, builder: (context, state) => const LoginView()),
      GoRoute(path: AppRouter.signUp, builder: (context, state) => const SignUpView()),
      GoRoute(path: AppRouter.forgotPassword, builder: (context, state) => const ForgotPasswordView()),
      GoRoute(
        path: AppRouter.resetPassword,
        builder: (context, state) {
          final email = state.extra as String? ?? '';
          return ResetPasswordView(email: email);
        },
      ),
      GoRoute(path: AppRouter.home, builder: (context, state) => const HomeView()),
    ],
  );
  AppRouter.registerRouter(router);
  ref.onDispose(AppRouter.unregisterRouter);
  return router;
});
