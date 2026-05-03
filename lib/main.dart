import 'package:flutter_starter/app/app.dart';
import 'package:flutter_starter/core/core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await loadAppEnv();
  setupLocator();

  runApp(const ProviderScope(child: App()));
}
