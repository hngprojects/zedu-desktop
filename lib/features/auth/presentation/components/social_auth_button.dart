import 'package:zedu/core/core.dart';

class SocialAuthButton extends StatelessWidget {
  const SocialAuthButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  final String icon;
  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return AppButton.outlined(
      label: label,
      onPressed: onPressed,
      leading: SvgPicture.asset(icon, width: 16, height: 16),
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: context.colors.borderOutline, width: 1),
        foregroundColor: context.colors.textPrimary,
        textStyle: context.textTheme.bodyLarge?.copyWith(
          fontWeight: FontWeight.w700,
          fontSize: 18,
        ),
      ),
    );
  }
}
