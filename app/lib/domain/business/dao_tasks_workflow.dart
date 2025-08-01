import 'package:app/domain/models/task.dart';

abstract class DaoTasksWorkflow {
  Future<List<Task>> getTasksByDaysWeek({required String daysWeek});
  Future<bool> createTask({required Task task});
  Future<bool> deleteTask({required Task task});
  Future<Task> updateTask({required Task task});
  Future<bool> setTaskChecked({required Task task});
}
