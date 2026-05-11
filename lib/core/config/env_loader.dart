import 'package:zedu/core/core.dart';

/// Loads [dotenv] from project-root `.env` / `.env.example` declared in
/// `pubspec.yaml` under `flutter.assets` (see Flutter asset docs).
///
/// Tries `.env` first, then `.env.example` so a missing `.env` still runs after
/// `flutter pub get`.
Future<void> loadAppEnv() async {
  try {
    await dotenv.load(fileName: '.env');
  } on Object {
    await dotenv.load(fileName: '.env.example');
  }
}
