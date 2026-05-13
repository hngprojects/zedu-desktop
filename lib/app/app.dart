import 'package:zedu/app/router_provider.dart';
import 'package:zedu/core/core.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(goRouterProvider);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Zedu',
      theme: AppTheme.light,
      routerConfig: router,
    );
  }
}
