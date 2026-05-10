import 'package:flutter_starter/core/core.dart';
import 'package:flutter_starter/core/utils/sizing_utils.dart';
import 'package:flutter_starter/core/widgets/app_button.dart';
import 'package:flutter_starter/core/widgets/app_text_field.dart';
import 'package:flutter_starter/features/auth/presentation/components/components.dart';
import 'package:flutter_starter/features/auth/presentation/providers/auth_providers_di.dart';
import 'package:flutter_starter/features/auth/presentation/providers/auth_state.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _rememberMe = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _showMessage(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _onLoginPressed() async {
    if (!_formKey.currentState!.validate()) return;

    ref
        .read(authNotifierProvider.notifier)
        .login(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AuthState>(authNotifierProvider, (previous, next) {
      if (previous?.status != AuthStatus.authenticated &&
          next.status == AuthStatus.authenticated) {
        context.go(AppRouter.home);
      }
    });

    final authState = ref.watch(authNotifierProvider);
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    if (authState.status == AuthStatus.unknown) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(color: theme.colorScheme.primary),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 68, vertical: 28),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  'assets/pngs/zedu_logo.png',
                  width: 88,
                  height: 31,
                  fit: BoxFit.contain,
                ),
                const SizedBox(),
                const Text('Already have an account?, Sign up'),
              ],
            ),
            const SizedBox(height: 16),
            // Center(
            //   child:
            // ),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 520),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 28),
                  Text(
                    'Login to Zedu',
                    style: TextStyle(
                      fontSize: 28,
                      color: Color(0xff1E1E1E),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Welcome back! We’ve missed you!',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xff0A090B),
                      fontWeight: FontWeight.w400,
                      height: 2,
                    ),
                  ),
                  context.verticalSpace(32),
                  SocialAuthButton(
                    icon: const Icon(Icons.g_mobiledata),
                    label: 'Sign up with Google',
                    onPressed: () =>
                        _showMessage('Google sign in is not available yet.'),
                  ),
                  const SizedBox(height: 12),
                  SocialAuthButton(
                    icon: const Icon(Icons.apple),
                    label: 'Sign up with Apple',
                    onPressed: () =>
                        _showMessage('Apple sign in is not available yet.'),
                  ),
                  const SizedBox(height: 26),
                  Row(
                    children: [
                      Expanded(
                        child: Divider(color: Color(0xffE5E7EB), height: 0.67),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          'OR',
                          style: textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurface.withValues(
                              alpha: 0.72,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(color: Color(0xffE5E7EB), height: 0.67),
                      ),
                    ],
                  ),
                  const SizedBox(height: 26),
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        AppTextField(
                          controller: _emailController,
                          label: 'Email address',
                          hint: 'Enter your email address',
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter your email.';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        AppTextField(
                          isPassword: true,
                          controller: _passwordController,
                          label: 'Password',
                          hint: 'Password',
                          textInputAction: TextInputAction.done,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter your password.';
                            }
                            return null;
                          },
                        ),
                        context.verticalSpace(8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  value: _rememberMe,
                                  onChanged: (value) {
                                    setState(() {
                                      _rememberMe = value ?? false;
                                    });
                                  },
                                ),
                                const Text('Remember me'),
                              ],
                            ),
                            TextButton(
                              onPressed: () => _showMessage(
                                'Forgot password is not implemented yet.',
                              ),
                              child: const Text('Forgot Password?'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  if (authState.error != null) ...[
                    const SizedBox(height: 12),
                    Text(
                      authState.error!,
                      textAlign: TextAlign.center,
                      style: textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.error,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                  const SizedBox(height: 18),
                  AppButton(
                    label: 'Login',
                    loading: authState.isLoading,
                    onPressed: _onLoginPressed,
                  ),
                  const SizedBox(height: 14),
                  Center(
                    child: TextButton(
                      onPressed: () => _showMessage(
                        'Magic link login is not implemented yet.',
                      ),
                      child: const Text('Login with magic link'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
