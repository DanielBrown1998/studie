import 'package:app/domain/business/dao_tasks_workflow.dart';
import 'package:app/domain/models/task.dart';

class DaoTasks extends DaoTasksWorkflow {
  @override
  Future<bool> createTask({required Task task}) {
    // TODO: implement createTask
    throw UnimplementedError();
  }

  @override
  Future<bool> deleteTask({required Task task}) {
    // TODO: implement deleteTask
    throw UnimplementedError();
  }

  @override
  Future<List<Task>> getTasksByDaysWeek({required String daysWeek}) {
    // TODO: implement getTasksByDaysWeek
    throw UnimplementedError();
  }

  @override
  Future<bool> setTaskChecked({required Task task}) {
    // TODO: implement setTaskChecked
    throw UnimplementedError();
  }

  @override
  Future<Task> updateTask({required Task task}) {
    // TODO: implement updateTask
    throw UnimplementedError();
  }
}
