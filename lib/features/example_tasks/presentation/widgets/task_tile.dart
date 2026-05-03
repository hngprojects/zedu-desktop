import 'package:flutter_starter/core/core.dart';
import 'package:flutter_starter/features/features.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({required this.task, super.key});

  final TaskModel task;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: CheckboxListTile(
        value: task.isCompleted,
        onChanged: null,
        title: Text(task.title),
      ),
    );
  }
}
