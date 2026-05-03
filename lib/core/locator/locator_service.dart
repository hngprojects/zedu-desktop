import 'package:flutter_starter/features/features.dart';
import 'package:flutter_starter/core/core.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator
    ..registerLazySingleton<AppConfig>(AppConfig.fromEnvironment)
    ..registerLazySingleton<ApiBaseService>(
      () => ApiBaseService(config: locator<AppConfig>()),
    )
    ..registerLazySingleton<TasksRepo>(
      () => TasksDatasource(
        config: locator<AppConfig>(),
        apiBaseService: locator<ApiBaseService>(),
      ),
    );
}
