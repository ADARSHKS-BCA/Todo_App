import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'task_model.g.dart';

@HiveType(typeId: 0)
class TaskModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String? description;

  @HiveField(3)
  final DateTime date;

  // Alias for code readability in UI
  DateTime? get dueDate => date;

  @HiveField(4)
  final String category;

  @HiveField(5)
  bool isCompleted;

  @HiveField(6)
  final String priority; // Low, Medium, High

  TaskModel({
    required this.id,
    required this.title,
    this.description,
    required this.date,
    required this.category,
    this.isCompleted = false,
    this.priority = 'Medium',
  });

  factory TaskModel.create({
    required String title,
    String? description,
    required DateTime date,
    required String category,
    String priority = 'Medium',
  }) {
    return TaskModel(
      id: const Uuid().v4(),
      title: title,
      description: description,
      date: date,
      category: category,
      priority: priority,
    );
  }
}
