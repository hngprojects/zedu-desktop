import 'package:flutter_starter/core/core.dart';
import 'package:flutter_starter/features/features.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockApiBaseService extends Mock implements ApiBaseService {}

void main() {
  test('returns sample tasks when mock data is enabled', () async {
    final datasource = TasksDatasource(
      config: const AppConfig(
        apiBaseUrl: 'https://example.com/api',
        usesMockData: true,
      ),
      apiBaseService: MockApiBaseService(),
    );

    final tasks = await datasource.getTasks();

    expect(tasks, isNotEmpty);
    expect(tasks.first.title, 'Create your first feature module');
  });

  test('maps api response to task models', () async {
    final apiBaseService = MockApiBaseService();

    when(() => apiBaseService.get<List<dynamic>>(path: '/tasks')).thenAnswer(
      (_) async => const ApiResponseModel<List<dynamic>>(
        data: <dynamic>[
          <String, dynamic>{
            'id': 1,
            'title': 'Build on the starter',
            'isCompleted': false,
          },
        ],
        statusCode: 200,
      ),
    );

    final datasource = TasksDatasource(
      config: const AppConfig(
        apiBaseUrl: 'https://example.com/api',
        usesMockData: false,
      ),
      apiBaseService: apiBaseService,
    );

    final tasks = await datasource.getTasks();

    expect(tasks.single.id, '1');
    expect(tasks.single.title, 'Build on the starter');
    expect(tasks.single.isCompleted, isFalse);
    verify(() => apiBaseService.get<List<dynamic>>(path: '/tasks')).called(1);
  });
}
