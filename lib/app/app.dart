import 'package:zedu/core/core.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Zedu',
      theme: AppTheme.light,
      routerConfig: AppRouter.router,
    );
  }
}
