import 'package:flutter_starter/core/core.dart';
import 'package:flutter_starter/features/features.dart';

final tasksRepoProvider = Provider<TasksRepo>((ref) {
  return locator<TasksRepo>();
});

final tasksProvider = FutureProvider<List<TaskModel>>((ref) {
  return ref.watch(tasksRepoProvider).getTasks();
});
