import 'package:flutter_starter/core/core.dart';

class TasksHeader extends StatelessWidget {
  const TasksHeader({required this.textTheme, super.key});

  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Example tasks', style: textTheme.headlineSmall),
        const SizedBox(height: 8),
        Text(
          'Copy this feature shape when adding real REST-backed work.',
          style: textTheme.bodyLarge,
        ),
      ],
    );
  }
}
