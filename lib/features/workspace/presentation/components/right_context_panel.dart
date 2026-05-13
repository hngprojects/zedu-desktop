import 'package:zedu/core/core.dart';

class RightContextPanel extends StatelessWidget {
  const RightContextPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final palette = AppPalette.light;

    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Container(
            height: 64,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: palette.divider)),
            ),
            alignment: Alignment.centerLeft,
            child: Text(
              'Learning Context',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: palette.textPrimary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: palette.background,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: palette.divider),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Text(
                      'Course materials and learning resources will appear here.',
                      textAlign: TextAlign.center,
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.copyWith(color: palette.textHint),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
