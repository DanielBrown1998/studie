import 'package:app/domain/business/dao_tasks_workflow.dart';
import 'package:app/domain/models/task.dart';
import 'package:get/get.dart';
import 'package:app/services/database.dart' as package_database;

class ControllerTask extends GetxController implements DaoTasksWorkflow {
  final package_database.AppDataBase database;
  RxString name = "".obs;
  RxList<Task> tasks = <Task>[].obs;

  ControllerTask({required this.database});

  Future<void> initializeController({required String name, required}) async {
    tasks.value = await getTasksByWeekDay(weekdays: name);
    this.name.value = name;
  }

  @override
  Future<int> createTask({required Task task}) {
    return database.createTask(task: task);
  }

  @override
  Future<int> deleteTask({required Task task}) {
    return database.deleteTask(task: task);
  }

  @override
  Future<List<Task>> getTasksByWeekDay({required String weekdays}) async {
    return await database.getTasksByWeekDay(weekdays: weekdays);
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
