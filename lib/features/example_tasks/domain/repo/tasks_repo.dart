import 'package:flutter_starter/features/features.dart';

abstract interface class TasksRepo {
  Future<List<TaskModel>> getTasks();
}
