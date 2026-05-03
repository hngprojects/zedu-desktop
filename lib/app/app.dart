import 'package:flutter_starter/app/theme/app_theme.dart';
import 'package:flutter_starter/core/core.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Starter',
      theme: AppTheme.light,
      routerConfig: AppRouter.router,
    );
  }
}
