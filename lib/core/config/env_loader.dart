import 'package:zedu/core/core.dart';

/// Loads [dotenv] from project-root env files bundled under `flutter.assets`.
///
/// Tries `.env` first (when listed as an asset and present), then `.env.example`
/// so fresh clones work with only the tracked template in `pubspec.yaml`.
Future<void> loadAppEnv() async {
  try {
    await dotenv.load(fileName: '.env');
  } on Object {
    await dotenv.load(fileName: '.env.example');
  }
}
