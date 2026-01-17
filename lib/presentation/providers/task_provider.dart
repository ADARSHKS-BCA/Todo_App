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
    state = _sortTasks(tasks);
  }

  List<TaskModel> _sortTasks(List<TaskModel> tasks) {
    // Sort logic: Overdue > Today > Upcoming > Completed
    // Secondary sort: Priority (High > Med > Low) not explicitly asked but good UX
    // Tertiary: Date
    tasks.sort((a, b) {
      if (a.isCompleted && !b.isCompleted) return 1;
      if (!a.isCompleted && b.isCompleted) return -1;
      
      // Both pending or both completed
      // Overdue check
      final now = DateTime.now();
      final aOverdue = a.date.isBefore(now);
      final bOverdue = b.date.isBefore(now);
      
      if (aOverdue && !bOverdue) return -1;
      if (!aOverdue && bOverdue) return 1;
      
      return a.date.compareTo(b.date);
    });
    return List.from(tasks);
  }

  Future<void> addTask({
    required String title,
    String? description,
    required DateTime date,
    required String category,
    required String priority,
  }) async {
    final newTask = TaskModel.create(
      title: title,
      description: description,
      date: date,
      category: category,
      priority: priority,
    );
    await _repository.addTask(newTask);
    await loadTasks();
  }

  Future<void> updateTask(TaskModel task) async {
    await _repository.updateTask(task);
    await loadTasks();
  }

  Future<void> toggleTaskCompletion(TaskModel task) async {
    task.isCompleted = !task.isCompleted;
    await task.save(); // HiveObject method
    await loadTasks();
  }

  Future<void> deleteTask(String id) async {
    await _repository.deleteTask(id);
    await loadTasks();
  }
}

// Derived providers for filtering
final filteredTasksProvider = Provider.family<List<TaskModel>, String>((ref, filter) {
  final tasks = ref.watch(taskListProvider);
  if (filter == 'Pending') return tasks.where((t) => !t.isCompleted).toList();
  if (filter == 'Completed') return tasks.where((t) => t.isCompleted).toList();
  return tasks;
});

final todayCountProvider = Provider((ref) {
  final tasks = ref.watch(taskListProvider);
  final now = DateTime.now();
  return tasks.where((t) => !t.isCompleted && 
    t.date.year == now.year && t.date.month == now.month && t.date.day == now.day).length;
});

final overdueCountProvider = Provider((ref) {
  final tasks = ref.watch(taskListProvider);
  return tasks.where((t) => !t.isCompleted && t.date.isBefore(DateTime.now())).length;
});

final upcomingCountProvider = Provider((ref) {
  final tasks = ref.watch(taskListProvider);
  return tasks.where((t) => !t.isCompleted && t.date.isAfter(DateTime.now())).length;
});
