import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:zedu/core/core.dart';
import 'package:zedu/core/theme/app_typography.dart';
import 'package:zedu/core/utils/validators.dart';
import 'package:zedu/features/features.dart';

class ResetPasswordView extends ConsumerStatefulWidget {
  const ResetPasswordView({super.key, required this.email});

  final String email;

  @override
  ConsumerState<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends ConsumerState<ResetPasswordView> {
  final _formKey = GlobalKey<FormState>();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  
  final List<TextEditingController> _tokenControllers = List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());

  Timer? _timer;
  int _secondsLeft = 300;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    setState(() => _secondsLeft = 300);
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsLeft > 0) {
        setState(() => _secondsLeft--);
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    for (var controller in _tokenControllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _onResetPasswordPressed() async {
    if (!_formKey.currentState!.validate()) return;

    final token = _tokenControllers.map((c) => c.text).join();
    if (token.length != 6) {
      AppToastService.show(context, type: AppToastType.error, message: 'Please enter the 6-digit verification code.');
      return;
    }

    final success = await ref.read(authNotifierProvider.notifier).resetPassword(
      email: widget.email,
      token: token,
      newPassword: _newPasswordController.text,
    );

    if (success && mounted) {
      AppToastService.show(context, type: AppToastType.success, message: 'Password reset successfully!');
      context.go(AppRouter.login);
    }
  }
  
  Future<void> _onResendCodePressed() async {
    if (_secondsLeft > 0) return;
    
    // Trigger forgot password again to resend code
    final success = await ref.read(authNotifierProvider.notifier).forgotPassword(email: widget.email);
    if (success && mounted) {
      AppToastService.show(context, type: AppToastType.success, message: 'New code sent to your email.');
      _startTimer();
    }
  }

  Widget _buildOTPInput() {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(6, (index) {
        return SizedBox(
          width: 56,
          height: 56,
          child: TextFormField(
            controller: _tokenControllers[index],
            focusNode: _focusNodes[index],
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(1),
            ],
            style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              counterText: '',
              contentPadding: EdgeInsets.zero,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: context.colors.divider),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: context.colors.primary, width: 2),
              ),
            ),
            onChanged: (value) {
              if (value.isNotEmpty && index < 5) {
                _focusNodes[index + 1].requestFocus();
              } else if (value.isEmpty && index > 0) {
                _focusNodes[index - 1].requestFocus();
              }
            },
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AuthState>(authNotifierProvider, (previous, next) {
      if (next.error != null && previous?.error != next.error) {
        AppToastService.show(context, type: AppToastType.error, message: next.error!);
      }
    });

    final authState = ref.watch(authNotifierProvider);
    final theme = Theme.of(context);

    // Format the email to mask it like pl***@gmail.com
    String maskedEmail = widget.email;
    if (maskedEmail.contains('@')) {
      final parts = maskedEmail.split('@');
      final local = parts[0];
      if (local.length > 2) {
        maskedEmail = '${local.substring(0, 2)}***@${parts[1]}';
      }
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
                    text: 'Go back to login? ',
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
                        recognizer: TapGestureRecognizer()..onTap = () => context.go(AppRouter.login),
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
                Text(
                  'Reset Password',
                  style: context.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w700),
                ),
                context.gapV(12),
                Text(
                  'Choose a new password for your account',
                  style: context.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: context.colors.textPrimary,
                  ),
                ),
                context.gapV(8),
                Text(
                  'We have sent a code to your email $maskedEmail',
                  style: context.textTheme.bodyMedium?.copyWith(color: context.colors.textSecondary),
                ),
                context.gapV(48),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Enter verification code',
                        style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
                      ),
                      context.gapV(8),
                      _buildOTPInput(),
                      context.gapV(24),
                      AppTextField(
                        isPassword: true,
                        controller: _newPasswordController,
                        label: 'Enter new password',
                        hint: 'Password',
                        textInputAction: TextInputAction.next,
                        validator: (value) => Validators.validatePassword(context, value),
                      ),
                      context.gapV(16),
                      AppTextField(
                        isPassword: true,
                        controller: _confirmPasswordController,
                        label: 'Confirm new password',
                        hint: 'Confirm new Password',
                        textInputAction: TextInputAction.done,
                        validator: (value) {
                          if (value != _newPasswordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      ),
                      context.gapV(32),
                      AppButton(
                        label: 'Reset Password',
                        loading: authState.isLoading,
                        onPressed: _onResetPasswordPressed,
                      ),
                      context.gapV(16),
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: context.colors.divider),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
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
                      context.gapV(32),
                      Center(
                        child: Text.rich(
                          TextSpan(
                            text: 'Resend code ',
                            style: context.textTheme.bodyMedium?.copyWith(
                              color: _secondsLeft > 0 ? context.colors.textPrimary : context.colors.primary,
                              fontWeight: FontWeight.w500,
                            ),
                            recognizer: TapGestureRecognizer()..onTap = _onResendCodePressed,
                            children: [
                              if (_secondsLeft > 0)
                                TextSpan(
                                  text: 'after ${_secondsLeft ~/ 60}:${(_secondsLeft % 60).toString().padLeft(2, '0')} mins',
                                  style: context.textTheme.bodyMedium?.copyWith(
                                    color: context.colors.primary,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                            ],
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
