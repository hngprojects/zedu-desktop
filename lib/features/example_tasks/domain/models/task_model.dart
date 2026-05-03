class TaskModel {
  const TaskModel({
    required this.id,
    required this.title,
    required this.isCompleted,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'].toString(),
      title: json['title'] as String? ?? 'Untitled task',
      isCompleted: json['isCompleted'] as bool? ?? false,
    );
  }

  final String id;
  final String title;
  final bool isCompleted;

  static const sampleTasks = <TaskModel>[
    TaskModel(
      id: '1',
      title: 'Create your first feature module',
      isCompleted: false,
    ),
    TaskModel(
      id: '2',
      title: 'Keep shared code out of features',
      isCompleted: true,
    ),
    TaskModel(
      id: '3',
      title: 'Add focused tests before the feature grows',
      isCompleted: false,
    ),
  ];

  TaskModel copyWith({String? id, String? title, bool? isCompleted}) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
