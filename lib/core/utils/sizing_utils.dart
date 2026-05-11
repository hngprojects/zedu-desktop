import 'package:zedu/core/core.dart';

extension MediaQueryValues on BuildContext {
  // ── Raw screen dimensions ────────────────────────────
  Size get screenSize => MediaQuery.sizeOf(this);
  double get screenWidth => screenSize.width;
  double get screenHeight => screenSize.height;

  // ── Percentage-of-screen spacers ─────────────────────
  SizedBox screenHeightSpace(double percent) =>
      SizedBox(height: percent * screenHeight);

  SizedBox screenWidthSpace(double percent) =>
      SizedBox(width: percent * screenWidth);

  // ── Scaling ──────────────────────────────────────────
  /// Uniform scale based on window width.
  /// 1.0 when window ≥ design width; proportionally smaller when narrower.
  double get _scale {
    final w = screenWidth;
    return w >= SizeConfig.baseWidth ? 1.0 : w / SizeConfig.baseWidth;
  }

  /// Scale a single dimension.
  double s(double value) => value * _scale;

  // ── Scaled spacers ───────────────────────────────────
  /// Vertical gap scaled from design value.
  SizedBox gapV(double value) => SizedBox(height: s(value));

  /// Horizontal gap scaled from design value.
  SizedBox gapH(double value) => SizedBox(width: s(value));

  // ── Scaled EdgeInsets ────────────────────────────────
  EdgeInsets all(double value) => EdgeInsets.all(s(value));

  EdgeInsets symmetric({double vertical = 0, double horizontal = 0}) =>
      EdgeInsets.symmetric(vertical: s(vertical), horizontal: s(horizontal));

  EdgeInsets only({
    double top = 0,
    double left = 0,
    double bottom = 0,
    double right = 0,
  }) => EdgeInsets.only(
    top: s(top),
    left: s(left),
    right: s(right),
    bottom: s(bottom),
  );
}

class SizeConfig {
  static double baseWidth = 1440;
}
