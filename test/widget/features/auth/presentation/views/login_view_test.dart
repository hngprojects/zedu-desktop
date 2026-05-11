import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zedu/features/features.dart';

// Fake notifier that avoids GetIt/locator setup while remaining type-compatible
// with authNotifierProvider (which is NotifierProvider<AuthNotifier, AuthState>).
class FakeAuthNotifier extends AuthNotifier {
  FakeAuthNotifier({
    AuthState initial = const AuthState(status: AuthStatus.unauthenticated),
    void Function(String email, String password)? onLogin,
  }) : _initial = initial,
       _onLogin = onLogin;

  final AuthState _initial;
  final void Function(String email, String password)? _onLogin;

  @override
  AuthState build() => _initial;

  @override
  Future<void> login({required String email, required String password}) async {
    _onLogin?.call(email, password);
  }

  @override
  Future<void> logout() async {
    state = const AuthState(status: AuthStatus.unauthenticated);
  }
}

Widget buildLoginViewUnderTest({FakeAuthNotifier? notifier}) {
  return ProviderScope(
    overrides: [
      authNotifierProvider.overrideWith(
        () => notifier ?? FakeAuthNotifier(),
      ),
    ],
    child: const MaterialApp(home: LoginView()),
  );
}

void main() {
  group('LoginView', () {
    testWidgets('renders form fields and login button when unauthenticated', (tester) async {
      await tester.pumpWidget(buildLoginViewUnderTest());
      await tester.pump();

      expect(find.text('Login to Zedu'), findsOneWidget);
      expect(find.text('Email address'), findsOneWidget);
      expect(find.text('Password'), findsWidgets);
      expect(find.widgetWithText(ElevatedButton, 'Login'), findsOneWidget);
    });

    testWidgets('shows loading spinner when auth status is unknown', (tester) async {
      await tester.pumpWidget(
        buildLoginViewUnderTest(
          notifier: FakeAuthNotifier(
            initial: const AuthState(status: AuthStatus.unknown),
          ),
        ),
      );
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('Login to Zedu'), findsNothing);
    });

    testWidgets('shows validation errors when submitting empty form', (tester) async {
      await tester.binding.setSurfaceSize(const Size(1440, 1024));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(buildLoginViewUnderTest());
      await tester.pump();

      final loginButton = find.widgetWithText(ElevatedButton, 'Login');
      await tester.ensureVisible(loginButton);
      await tester.tap(loginButton);
      await tester.pumpAndSettle();

      expect(find.text('Email is required'), findsOneWidget);
      expect(find.text('Password is required'), findsOneWidget);
    });

    testWidgets('calls login with correct credentials when form is valid', (tester) async {
      await tester.binding.setSurfaceSize(const Size(1440, 1024));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      String? capturedEmail;
      String? capturedPassword;

      await tester.pumpWidget(
        buildLoginViewUnderTest(
          notifier: FakeAuthNotifier(
            onLogin: (email, password) {
              capturedEmail = email;
              capturedPassword = password;
            },
          ),
        ),
      );
      await tester.pump();

      await tester.enterText(find.byType(TextFormField).at(0), 'user@example.com');
      await tester.enterText(find.byType(TextFormField).at(1), 'Secret123');

      final loginButton = find.widgetWithText(ElevatedButton, 'Login');
      await tester.ensureVisible(loginButton);
      await tester.tap(loginButton);
      await tester.pumpAndSettle();

      expect(capturedEmail, 'user@example.com');
      expect(capturedPassword, 'Secret123');
    });
  });
}
