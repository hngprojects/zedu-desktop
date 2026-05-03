import 'package:flutter_starter/core/core.dart';
import 'package:flutter_starter/features/features.dart';

class TasksView extends ConsumerWidget {
  const TasksView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(tasksProvider);
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Starter'),
        actions: [
          IconButton(
            onPressed: () => ref.invalidate(tasksProvider),
            icon: const Icon(Icons.refresh),
            tooltip: 'Refresh tasks',
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TasksHeader(textTheme: textTheme),
              const SizedBox(height: 24),
              Expanded(
                child: tasks.when(
                  data: (tasks) => _TaskList(tasks: tasks),
                  error: (error, _) => _FailureMessage(message: '$error'),
                  loading: () => const LinearProgressIndicator(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TaskList extends StatelessWidget {
  const _TaskList({required this.tasks});

  final List<TaskModel> tasks;

  @override
  Widget build(BuildContext context) {
    if (tasks.isEmpty) {
      return const Center(child: Text('No tasks yet.'));
    }

    return ListView.separated(
      itemCount: tasks.length,
      separatorBuilder: (_, _) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final task = tasks[index];

        return TaskTile(task: task);
      },
    );
  }
}

class _FailureMessage extends StatelessWidget {
  const _FailureMessage({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(message, style: TextStyle(color: colorScheme.error)),
    );
  }
}
