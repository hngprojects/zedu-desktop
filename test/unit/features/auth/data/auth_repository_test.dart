import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:zedu/core/core.dart';
import 'package:zedu/features/features.dart';

class MockAuthRemoteDataSource extends Mock implements AuthRemoteDataSource {}

class MockAuthLocalDataSource extends Mock implements AuthLocalDataSource {}

void main() {
  group('AuthRepositoryImpl', () {
    late MockAuthRemoteDataSource mockDatasource;
    late MockAuthLocalDataSource mockLocal;
    late AuthRepositoryImpl repository;

    setUp(() {
      mockDatasource = MockAuthRemoteDataSource();
      mockLocal = MockAuthLocalDataSource();
      repository = AuthRepositoryImpl(remote: mockDatasource, local: mockLocal);
    });

    group('login', () {
      test('returns Success<AuthSession> when datasource succeeds', () async {
        final mockResponse = LoginResponseModel.fromJson(
          LoginResponseModel.mockLoginResponse,
        );

        when(
          () => mockDatasource.login(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenAnswer((_) async => mockResponse);

        final result = await repository.login(
          email: 'test@example.com',
          password: 'Password123',
        );

        expect(result, isA<Success<AuthSession>>());
        final session = (result as Success<AuthSession>).value;
        expect(session.accessToken, mockResponse.accessToken);
        expect(session.user.email, mockResponse.user.email);
      });

      test('returns Failure when datasource throws ApiFailure', () async {
        when(
          () => mockDatasource.login(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenThrow(
          const ApiFailure(
            message: 'Invalid credentials',
            kind: ApiFailureKind.client,
          ),
        );

        final result = await repository.login(
          email: 'test@example.com',
          password: 'wrongpass',
        );

        expect(result, isA<Failure<AuthSession>>());
      });

      test('returns Failure for unexpected errors', () async {
        when(
          () => mockDatasource.login(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenThrow(Exception('unexpected error'));

        final result = await repository.login(
          email: 'test@example.com',
          password: 'password',
        );

        expect(result, isA<Failure<AuthSession>>());
      });
    });

    group('getCurrentUser', () {
      test('returns Success<User> when datasource succeeds', () async {
        final mockUser = LoginResponseModel.fromJson(
          LoginResponseModel.mockLoginResponse,
        ).user;

        when(() => mockDatasource.me()).thenAnswer((_) async => mockUser);

        final result = await repository.getCurrentUser();

        expect(result, isA<Success<User>>());
        final user = (result as Success<User>).value;
        expect(user.email, mockUser.email);
      });

      test('returns Failure when datasource throws ApiFailure', () async {
        when(() => mockDatasource.me()).thenThrow(
          const ApiFailure(
            message: 'Unauthorized',
            kind: ApiFailureKind.unauthorized,
          ),
        );

        final result = await repository.getCurrentUser();

        expect(result, isA<Failure<User>>());
      });

      test('returns Failure for unexpected errors', () async {
        when(() => mockDatasource.me()).thenThrow(Exception('unexpected'));

        final result = await repository.getCurrentUser();

        expect(result, isA<Failure<User>>());
      });
    });

    group('logout', () {
      test('clears local session when remote succeeds', () async {
        when(() => mockDatasource.logout()).thenAnswer((_) async {});
        when(() => mockLocal.clearSession()).thenAnswer((_) async {});

        await repository.logout();

        verifyInOrder([
          () => mockDatasource.logout(),
          () => mockLocal.clearSession(),
        ]);
      });

      test('still clears local session when remote throws ApiFailure', () async {
        when(() => mockDatasource.logout()).thenThrow(
          const ApiFailure(
            message: 'Server error',
            kind: ApiFailureKind.server,
          ),
        );
        when(() => mockLocal.clearSession()).thenAnswer((_) async {});

        await expectLater(repository.logout(), completes);

        verify(() => mockDatasource.logout()).called(1);
        verify(() => mockLocal.clearSession()).called(1);
      });

      test('still clears local session when remote throws unexpectedly', () async {
        when(() => mockDatasource.logout()).thenThrow(Exception('boom'));
        when(() => mockLocal.clearSession()).thenAnswer((_) async {});

        await expectLater(repository.logout(), completes);

        verify(() => mockDatasource.logout()).called(1);
        verify(() => mockLocal.clearSession()).called(1);
      });
    });
  });
}
