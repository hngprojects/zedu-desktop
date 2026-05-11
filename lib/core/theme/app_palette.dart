import 'package:zedu/core/core.dart';

class AppPalette {
  final Brightness brightness;
  final Color primary;
  final Color background;
  final Color textPrimary;
  final Color textSecondary;
  final Color textHint;
  final Color borderOutline;
  final Color divider;
  final Color success;
  final Color successBg;
  final Color error;
  final Color errorBg;

  const AppPalette({
    required this.brightness,
    required this.primary,
    required this.background,
    required this.textPrimary,
    required this.textSecondary,
    required this.textHint,
    required this.borderOutline,
    required this.divider,
    required this.success,
    required this.successBg,
    required this.error,
    required this.errorBg,
  });

  static const light = AppPalette(
    brightness: Brightness.light,
    primary: Color(0xFF7141F8),
    background: Color(0xFFFCFBFF),
    textPrimary: Color(0xFF1E1E1E),
    textSecondary: Color(0xFF0A090B),
    textHint: Color(0xFFA3A3A3),
    borderOutline: Color(0xffD0D0FD),
    divider: Color(0xffE5E7EB),
    success: Color(0xFF22C55E),
    successBg: Color(0xFFEFFFF5),
    error: Color(0xFFEF4444),
    errorBg: Color(0xFFFFF1F1),
  );
}
