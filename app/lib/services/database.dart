import 'package:app/domain/business/dao_tasks_workflow.dart';
import 'package:app/domain/models/task.dart';
import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';

part 'database.g.dart';
part 'table_task.dart';

@DriftDatabase(tables: [TableTasks])
class AppDataBase extends _$AppDataBase implements DaoTasksWorkflow {
  AppDataBase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  //used in getTaskByWeekDay
  Task _converterTableTaskInTask(TableTask table) {
    return Task(
      timeStart: table.timeStart,
      timeEnd: table.timeEnd,
      description: table.description,
      discipline: table.discipline,
      checked: table.checked,
      uid: table.uid,
      daysWeek: table.daysWeek,
    );
  }

  //used in createTask
  TableTasksCompanion _converterTaskInTableTasksCompanion(Task task) {
    return TableTasksCompanion.insert(
      discipline: task.discipline,
      description: task.description,
      daysWeek: task.daysWeek,
      timeStart: task.timeStart,
      timeEnd: task.timeEnd,
    );
  }

  //used in deleteTask
  TableTask _converterTaskInTableTasks(Task task) {
    if (task.uid == null) {
      throw TaskNotExistsException(
        " not found: ${task.discipline}: ${task.description} ",
      );
    }
    return TableTask(
      uid: task.uid!,
      discipline: task.discipline,
      description: task.description,
      checked: task.checked,
      daysWeek: task.daysWeek,
      timeStart: task.timeStart,
      timeEnd: task.timeEnd,
    );
  }

  @override
  Future<int> createTask({required Task task}) async {
    return await into(
      tableTasks,
    ).insert(_converterTaskInTableTasksCompanion(task));
  }

  @override
  Future<int> deleteTask({required Task task}) async {
    return await delete(tableTasks).delete(_converterTaskInTableTasks(task));
  }

  @override
  Future<List<Task>> getTasksByWeekDay({required String weekdays}) async {
    final query = select(tableTasks)
      ..where((tbl) => tbl.daysWeek.like('%$weekdays%'));
    final tasksForDay = await query.get();
    return tasksForDay.map(_converterTableTaskInTask).toList();
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

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'my_database',
      native: const DriftNativeOptions(
        databaseDirectory: getApplicationSupportDirectory,
      ),
    );
  }
}

class TaskNotExistsException implements Exception {
  final String message;
  TaskNotExistsException(this.message);

  @override
  String toString() {
    return message;
  }
}
