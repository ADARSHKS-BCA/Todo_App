import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app/data/models/task_model.dart';

void main() {
  group('TaskModel', () {
    test('should create task with unique id', () {
      final task = TaskModel.create(
        title: 'Test Task',
        date: DateTime.now(),
        category: 'Work',
      );
      
      expect(task.id, isNotEmpty);
      expect(task.title, 'Test Task');
      expect(task.isCompleted, false);
    });
  });
}
