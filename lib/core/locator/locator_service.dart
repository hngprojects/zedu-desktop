import 'package:flutter_starter/features/features.dart';
import 'package:flutter_starter/core/core.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator
    ..registerLazySingleton<AppConfig>(AppConfig.fromEnvironment)
    ..registerLazySingleton<SecureStorageService>(() => SecureStorageService());

  final config = locator<AppConfig>();
  final storage = locator<SecureStorageService>();

  final authInterceptor = AuthInterceptor(storage: storage);
  locator.registerLazySingleton<AuthInterceptor>(() => authInterceptor);

  final dio = Dio(BaseOptions(baseUrl: config.apiBaseUrl));
  dio.interceptors.add(authInterceptor);

  locator
    ..registerLazySingleton<ApiBaseService>(
      () => ApiBaseService(config: config, dio: dio),
    )
    ..registerLazySingleton<TasksRepo>(
      () => TasksDatasource(
        config: config,
        apiBaseService: locator<ApiBaseService>(),
      ),
    );
}
