// ============================================================
// AppButton — Reusable button for EventRun
// ============================================================
//
// Usage:
//
//   AppButton(
//     label: 'Save Client',
//     onPressed: () => ...,
//   )
//
//   AppButton(
//     label: 'Next Step',
//     onPressed: _handleSubmit,
//     loading: isSubmitting,
//     trailing: Icons.arrow_forward,
//   )
//
//   AppButton.outlined(
//     label: 'Cancel',
//     onPressed: () => Navigator.pop(context),
//   )
//
//   AppButton.ghost(
//     label: 'Skip for now',
//     onPressed: () => ...,
//   )
// ============================================================

import 'package:zedu/core/core.dart';

enum _AppButtonVariant { filled, outlined, ghost }

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    this.onPressed,
    this.loading = false,
    this.disabled = false,
    this.leading,
    this.trailing,
    this.expand = true,
    this.height = 57,
    this.style,
  }) : _variant = _AppButtonVariant.filled;

  const AppButton.outlined({
    super.key,
    required this.label,
    this.onPressed,
    this.loading = false,
    this.disabled = false,
    this.leading,
    this.trailing,
    this.expand = true,
    this.height = 57,
    this.style,
  }) : _variant = _AppButtonVariant.outlined;

  const AppButton.ghost({
    super.key,
    required this.label,
    this.onPressed,
    this.loading = false,
    this.disabled = false,
    this.leading,
    this.trailing,
    this.expand = true,
    this.height = 57,
    this.style,
  }) : _variant = _AppButtonVariant.ghost;

  final String label;
  final VoidCallback? onPressed;
  final bool loading;
  final bool disabled;
  final Widget? leading;
  final Widget? trailing;

  final bool expand;
  final double height;
  final ButtonStyle? style;
  final _AppButtonVariant _variant;

  bool get _isDisabled => disabled || onPressed == null;

  @override
  Widget build(BuildContext context) {
    final child = _buildChild(context);

    Widget button = switch (_variant) {
      _AppButtonVariant.filled => ElevatedButton(
        onPressed: _isDisabled || loading ? null : onPressed,
        style: style,
        child: child,
      ),
      _AppButtonVariant.outlined => OutlinedButton(
        onPressed: _isDisabled || loading ? null : onPressed,
        style: style,
        child: child,
      ),
      _AppButtonVariant.ghost => TextButton(
        onPressed: _isDisabled || loading ? null : onPressed,
        style: style,
        child: child,
      ),
    };

    return SizedBox(
      width: expand ? double.infinity : null,
      height: height,
      child: button,
    );
  }

  Widget _buildChild(BuildContext context) {
    if (loading) {
      final color = switch (_variant) {
        _AppButtonVariant.filled => Colors.white,
        _ => Theme.of(context).colorScheme.primary,
      };

      return SizedBox(
        width: 22,
        height: 22,
        child: CircularProgressIndicator(color: color, strokeWidth: 2.5),
      );
    }

    final hasLeading = leading != null;
    final hasTrailing = trailing != null;

    return Row(
      mainAxisSize: expand ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (hasLeading) ...[leading!, const SizedBox(width: 4)],
        Flexible(
          child: Text(label, maxLines: 1, overflow: TextOverflow.ellipsis),
        ),
        if (hasTrailing) ...[const SizedBox(width: 8), trailing!],
      ],
    );
  }
}
