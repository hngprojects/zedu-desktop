import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_starter/features/features.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../helpers/test_material_app.dart';

class FakeTasksRepo implements TasksRepo {
  @override
  Future<List<TaskModel>> getTasks() async {
    return const <TaskModel>[
      TaskModel(id: '1', title: 'Build on the starter', isCompleted: false),
    ];
  }
}

void main() {
  testWidgets('shows tasks from the provider', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [tasksRepoProvider.overrideWithValue(FakeTasksRepo())],
        child: buildTestMaterialApp(const TasksView()),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Example tasks'), findsOneWidget);
    expect(find.text('Build on the starter'), findsOneWidget);
  });
}
