import 'package:zedu/features/auth/domain/repository/auth_repository.dart';

class LogoutUseCase {
  const LogoutUseCase({required AuthRepository repository})
    : _repository = repository;

  final AuthRepository _repository;

  Future<void> call() => _repository.logout();
}
