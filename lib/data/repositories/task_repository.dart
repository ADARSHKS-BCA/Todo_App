import 'package:hive_flutter/hive_flutter.dart';
import '../models/task_model.dart';

class TaskRepository {
  static const String boxName = 'tasks';

  Future<Box<TaskModel>> get _box async {
    if (Hive.isBoxOpen(boxName)) {
      return Hive.box<TaskModel>(boxName);
    }
    return await Hive.openBox<TaskModel>(boxName);
  }

  Future<void> addTask(TaskModel task) async {
    final box = await _box;
    await box.put(task.id, task);
  }

  Future<void> updateTask(TaskModel task) async {
    final box = await _box;
    await box.put(task.id, task);
  }

  Future<void> deleteTask(String id) async {
    final box = await _box;
    await box.delete(id);
  }

  Future<List<TaskModel>> getTasks() async {
    final box = await _box;
    return box.values.toList();
  }
}
