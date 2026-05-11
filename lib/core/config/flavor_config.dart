import 'package:flutter_dotenv/flutter_dotenv.dart';

enum AppFlavor { development, staging, production }

class AppFlavorConfig {
  AppFlavorConfig._();

  static final AppFlavor currentFlavor = _loadFlavor();

  static bool get isProduction => currentFlavor == AppFlavor.production;
  static bool get isStaging => currentFlavor == AppFlavor.staging;
  static bool get isDevelopment => currentFlavor == AppFlavor.development;

  static AppFlavor _loadFlavor() {
    const defineFlavor = String.fromEnvironment('APP_FLAVOR');
    final envFlavor = dotenv.maybeGet('APP_FLAVOR')?.trim();

    final rawFlavor = defineFlavor.isNotEmpty
        ? defineFlavor
        : (envFlavor?.isNotEmpty == true ? envFlavor! : 'development');

    switch (rawFlavor.toLowerCase()) {
      case 'production':
        return AppFlavor.production;
      case 'staging':
        return AppFlavor.staging;
      default:
        return AppFlavor.development;
    }
  }
}
