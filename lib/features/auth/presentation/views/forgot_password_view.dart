import 'package:flutter/gestures.dart';
import 'package:zedu/core/core.dart';
import 'package:zedu/core/theme/app_typography.dart';
import 'package:zedu/core/utils/validators.dart';
import 'package:zedu/features/features.dart';

class ForgotPasswordView extends ConsumerStatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  ConsumerState<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends ConsumerState<ForgotPasswordView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _onSubmitPressed() async {
    if (!_formKey.currentState!.validate()) return;

    final success = await ref
        .read(authNotifierProvider.notifier)
        .forgotPassword(email: _emailController.text.trim());

    if (success && mounted) {
      AppToastService.show(
        context,
        type: AppToastType.success,
        message: 'Password reset instructions sent!',
      );
      // Optional: Navigate to a success screen or back to login
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AuthState>(authNotifierProvider, (previous, next) {
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
                    text: 'Remember your password? ',
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
                context.gapV(136),
                Text(
                  'Forgot Password',
                  style: context.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                context.gapV(12),
                Text(
                  'Enter the email you used in creating your account, we will send you\ninstructions on how to reset your password.',
                  textAlign: TextAlign.center,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: context.colors.textSecondary,
                  ),
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
                        hint: 'johndoe@email.com',
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.done,
                        validator: (value) =>
                            Validators.validateEmail(context, value),
                      ),
                      context.gapV(24),
                      AppButton(
                        label: 'Submit',
                        loading: authState.isLoading,
                        onPressed: _onSubmitPressed,
                      ),
                      context.gapV(16),
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: context.colors.divider),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () => context.go(AppRouter.login),
                          child: Text(
                            'Back to Login',
                            style: context.textTheme.titleMedium?.copyWith(
                              color: context.colors.primary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
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
