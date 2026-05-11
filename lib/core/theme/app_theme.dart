import 'package:zedu/core/core.dart';
import 'app_typography.dart';

abstract final class AppTheme {
  static const _buttonRadius = 6.0;

  static final _buttonShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(_buttonRadius),
  );

  static const _buttonPadding = EdgeInsets.symmetric(
    horizontal: 24,
    vertical: 18,
  );

  static const _buttonTextStyle = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 16,
    fontVariations: [FontVariation('wght', 600)],
  );

  static final ThemeData light = _build(AppPalette.light, Brightness.light);

  static ThemeData _build(AppPalette palette, Brightness brightness) {
    return ThemeData(
      brightness: palette.brightness,
      primaryColor: palette.primary,
      scaffoldBackgroundColor: palette.background,
      textTheme: AppTypography.textTheme.apply(
        bodyColor: palette.textPrimary,
        displayColor: palette.textPrimary,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: palette.primary,
          shape: _buttonShape,
          padding: _buttonPadding,
          foregroundColor: Colors.white,
          textStyle: _buttonTextStyle.copyWith(color: Colors.white),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: palette.primary,
          shape: _buttonShape,
          padding: _buttonPadding,
          textStyle: _buttonTextStyle.copyWith(color: palette.primary),
          side: BorderSide(color: palette.primary, width: 1),
        ),
      ),
    );
  }
}
