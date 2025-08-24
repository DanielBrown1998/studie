import 'package:app/domain/business/dao_tasks_workflow.dart';
import 'package:app/domain/models/task.dart';
import 'package:get/get.dart';
import 'package:app/source/database/database.dart' as package_database;

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
    final result = database.createTask(task: task);
    tasks.add(task);
    return result;
  }

  @override
  Future<int> deleteTask({required Task task}) {
    tasks.remove(task);
    return database.deleteTask(task: task);
  }

  @override
  Future<List<Task>> getTasksByWeekDay({required String weekdays}) async {
    return await database.getTasksByWeekDay(weekdays: weekdays);
  }

  @override
  Future<bool> setTaskChecked({required Task task}) async {
    return await database.setTaskChecked(task: task);
  }

  @override
  Future<Task?> updateTask({required Task task}) async {
    final Task? result = await database.updateTask(task: task);
    return result;
  }
}
