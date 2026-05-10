import 'package:flutter_starter/core/core.dart';
import 'package:flutter_starter/features/features.dart';

final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>(
  (ref) => AuthRemoteDataSourceImpl(
    config: locator<AppConfig>(),
    apiBaseService: locator<ApiBaseService>(),
  ),
);

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepositoryImpl(remote: ref.watch(authRemoteDataSourceProvider)),
);

final authNotifierProvider =
    NotifierProvider<AuthNotifier, AuthState>(AuthNotifier.new);
