import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/task_model.dart';
import '../../data/repositories/task_repository.dart';

final taskRepositoryProvider = Provider((ref) => TaskRepository());

final taskListProvider = StateNotifierProvider<TaskNotifier, List<TaskModel>>((ref) {
  return TaskNotifier(ref.watch(taskRepositoryProvider));
});

class TaskNotifier extends StateNotifier<List<TaskModel>> {
  final TaskRepository _repository;

  TaskNotifier(this._repository) : super([]) {
    loadTasks();
  }

  Future<void> loadTasks() async {
    final tasks = await _repository.getTasks();
    // Sort by date usually, or completion
    tasks.sort((a, b) => a.date.compareTo(b.date));
    state = tasks;
  }

  Future<void> addTask({
    required String title,
    String? description,
    required DateTime date,
    required String category,
  }) async {
    final newTask = TaskModel.create(
      title: title,
      description: description,
      date: date,
      category: category,
    );
    await _repository.addTask(newTask);
    await loadTasks();
  }

  Future<void> toggleTaskCompletion(TaskModel task) async {
    task.isCompleted = !task.isCompleted;
    await task.save(); // HiveObject method
    // Or use repository.updateTask(task)
    await loadTasks();
  }

  Future<void> deleteTask(String id) async {
    await _repository.deleteTask(id);
    await loadTasks();
  }
}

// Derived providers for filtering
final todayTasksProvider = Provider((ref) {
  final tasks = ref.watch(taskListProvider);
  final now = DateTime.now();
  return tasks.where((task) {
    if (task.isCompleted) return false; // Show only pending in today? Or all? User said "Today's Tasks" with checkbox.
    final taskDate = task.date;
    return taskDate.year == now.year && taskDate.month == now.month && taskDate.day == now.day;
  }).toList();
});

final scheduledTasksProvider = Provider((ref) {
  final tasks = ref.watch(taskListProvider);
  return tasks.where((t) => !t.isCompleted && t.date.isAfter(DateTime.now())).toList();
});

final overdueTasksProvider = Provider((ref) {
  final tasks = ref.watch(taskListProvider);
  final now = DateTime.now();
  final todayStart = DateTime(now.year, now.month, now.day);
  return tasks.where((t) => !t.isCompleted && t.date.isBefore(todayStart)).toList();
});
