import 'package:zedu/core/core.dart';
import 'package:zedu/core/theme/app_typography.dart';
import 'package:zedu/core/utils/validators.dart';
import 'package:zedu/features/features.dart';

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

  Future<void> _onLoginPressed() async {
    if (!_formKey.currentState!.validate()) return;

    await ref
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
        AppToastService.show(
          context,
          type: AppToastType.success,
          message: 'Logged in successfully!',
        );
        context.go(AppRouter.home);
      }
      if (next.error != null && previous?.error != next.error) {
        AppToastService.show(
          context,
          type: AppToastType.error,
          message: next.error!,
        );
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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: SafeArea(
          child: Padding(
            padding: context.symmetric(horizontal: 68, vertical: 28),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset('assets/pngs/zedu_logo.png', width: 83, height: 31),
                Text.rich(
                  TextSpan(
                    text: "Don't have an account? ",
                    style: context.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w400,
                      color: context.colors.textPrimary,
                      fontFamily: FontFamily.roboto,
                    ),
                    children: [
                      TextSpan(
                        text: 'Sign up',
                        style: context.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w400,
                          color: context.colors.primary,
                          fontFamily: FontFamily.roboto,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                context.gapV(136),
                Text('Login to Zedu', style: context.textTheme.headlineMedium),
                context.gapV(8),
                Text(
                  'Welcome back! We’ve missed you!',
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: context.colors.textSecondary,
                  ),
                ),
                context.gapV(32),
                SocialAuthButton(
                  icon: 'assets/svgs/google_logo.svg',
                  label: 'Sign up with Google',
                  onPressed: () => AppToastService.show(
                    context,
                    type: AppToastType.info,
                    message: 'Google sign in is not available yet.',
                  ),
                ),
                context.gapV(12),
                SocialAuthButton(
                  icon: 'assets/svgs/apple_logo.svg',
                  label: 'Sign up with Apple',
                  onPressed: () => AppToastService.show(
                    context,
                    type: AppToastType.info,
                    message: 'Apple sign in is not available yet.',
                  ),
                ),
                context.gapV(26),
                Padding(
                  padding: context.symmetric(horizontal: 100, vertical: 0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: context.colors.divider,
                          height: 0.67,
                        ),
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
                        child: Divider(
                          color: context.colors.divider,
                          height: 0.67,
                        ),
                      ),
                    ],
                  ),
                ),
                context.gapV(26),
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
                        validator: (value) =>
                            Validators.validateEmail(context, value),
                      ),
                      context.gapV(16),
                      AppTextField(
                        isPassword: true,
                        controller: _passwordController,
                        label: 'Password',
                        hint: 'Password',
                        textInputAction: TextInputAction.done,
                        validator: (value) =>
                            Validators.validatePassword(context, value),
                      ),
                      context.gapV(8),
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
                          Text(
                            'Forgot Password?',
                            style: context.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w400,
                              color: context.colors.primary,
                              fontFamily: FontFamily.roboto,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                context.gapV(18),
                AppButton(
                  label: 'Login',
                  loading: authState.isLoading,
                  onPressed: _onLoginPressed,
                ),
                context.gapV(12),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Login with magic link',
                    style: context.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w400,
                      color: context.colors.primary,
                      fontFamily: FontFamily.roboto,
                    ),
                  ),
                ),
                context.gapV(32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
