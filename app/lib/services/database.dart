import 'package:drift/drift.dart';

part 'database.g.dart';

class TableTasks extends Table {
  IntColumn get uid => integer().named("uid").autoIncrement()();
  TextColumn get discipline =>
      text().named("discipline").withLength(min: 6, max: 12)();
  TextColumn get description =>
      text().named("description").withLength(max: 255)();
  BoolColumn get checked => boolean().named("checked")();
  TextColumn get daysWeek => text().named("daysWeek")();
  DateTimeColumn get timeStart => dateTime().named("timeStart")();
  DateTimeColumn get timeEnd => dateTime().named("timeEnd")();
}

@DriftDatabase(tables: [TableTasks])
class AppDataBase extends _$AppDataBase {
  AppDataBase(super.e);

  @override
  int get schemaVersion => 1;
}
