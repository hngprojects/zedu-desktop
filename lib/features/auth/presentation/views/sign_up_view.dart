import 'package:flutter/gestures.dart';
import 'package:zedu/core/core.dart';
import 'package:zedu/core/theme/app_typography.dart';
import 'package:zedu/core/utils/validators.dart';
import 'package:zedu/features/features.dart';

class SignUpView extends ConsumerStatefulWidget {
  const SignUpView({super.key});

  @override
  ConsumerState<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends ConsumerState<SignUpView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _staySignedIn = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _onCreateAccountPressed() async {
    if (!_formKey.currentState!.validate()) return;

    ref
        .read(authNotifierProvider.notifier)
        .signUp(
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
          message: 'Account created successfully!',
        );
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
                    text: 'Already have an account? ',
                    style: context.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w400,
                      color: context.colors.textPrimary,
                      fontFamily: FontFamily.roboto,
                    ),
                    children: [
                      TextSpan(
                        text: 'Sign in',
                        style: context.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w400,
                          color: context.colors.primary,
                          fontFamily: FontFamily.roboto,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => context.go(AppRouter.login),
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
                context.gapV(80),
                Text.rich(
                  TextSpan(
                    text: 'Stay Focused While ',
                    style: context.textTheme.headlineMedium?.copyWith(
                      color: context.colors.textPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                    children: [
                      TextSpan(
                        text: 'Zedu Handles The\nHustle',
                        style: context.textTheme.headlineMedium?.copyWith(
                          color: context.colors.primary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
                context.gapV(48),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      AppTextField(
                        controller: _emailController,
                        label: 'Email address',
                        hint: 'Enter your email',
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
                        validator: (value) {
                          if (value == null || value.length < 8) {
                            return 'Password must be at least 8 characters long';
                          }
                          return null;
                        },
                      ),
                      context.gapV(16),
                      Row(
                        children: [
                          Checkbox(
                            value: _staySignedIn,
                            onChanged: (value) {
                              setState(() {
                                _staySignedIn = value ?? false;
                              });
                            },
                          ),
                          const Text('Stay Signed In'),
                        ],
                      ),
                    ],
                  ),
                ),
                context.gapV(24),
                AppButton(
                  label: 'Create Account',
                  loading: authState.isLoading,
                  onPressed: _onCreateAccountPressed,
                ),
                context.gapV(32),
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
                context.gapV(32),
                SocialAuthButton(
                  icon: 'assets/svgs/google_logo.svg',
                  label: 'Sign up with Google',
                  onPressed: () => AppToastService.show(
                    context,
                    type: AppToastType.info,
                    message: 'Google sign up is not available yet.',
                  ),
                ),
                context.gapV(12),
                SocialAuthButton(
                  icon: 'assets/svgs/apple_logo.svg',
                  label: 'Sign up with Apple',
                  onPressed: () => AppToastService.show(
                    context,
                    type: AppToastType.info,
                    message: 'Apple sign up is not available yet.',
                  ),
                ),
                context.gapV(32),
                Text.rich(
                  TextSpan(
                    text: 'By Signing up, you agree to our ',
                    style: context.textTheme.bodySmall?.copyWith(
                      color: context.colors.textSecondary,
                    ),
                    children: [
                      TextSpan(
                        text: 'terms of service',
                        style: context.textTheme.bodySmall?.copyWith(
                          color: context.colors.primary,
                        ),
                        recognizer: TapGestureRecognizer()..onTap = () {},
                      ),
                      const TextSpan(text: ' and '),
                      TextSpan(
                        text: 'privacy policy',
                        style: context.textTheme.bodySmall?.copyWith(
                          color: context.colors.primary,
                        ),
                        recognizer: TapGestureRecognizer()..onTap = () {},
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
                context.gapV(48),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
