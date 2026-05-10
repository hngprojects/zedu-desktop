import 'package:flutter_starter/core/core.dart';
import 'package:flutter_starter/features/features.dart';

class TasksDatasource implements TasksRepo {
  const TasksDatasource({
    required AppConfig config,
    required ApiBaseService apiBaseService,
  }) : _config = config,
       _apiBaseService = apiBaseService;

  final AppConfig _config;
  final ApiBaseService _apiBaseService;

  @override
  Future<List<TaskModel>> getTasks() async {
    try {
      if (_config.usesMockData) {
        return TaskModel.sampleTasks;
      }

      final response = await _apiBaseService.get<List<dynamic>>(path: '/tasks');

      return response.data
          .whereType<Map<String, dynamic>>()
          .map(TaskModel.fromJson)
          .toList();
    } on ApiFailure {
      rethrow;
    }
  }
}
