import 'package:app/services/database.dart';

class DatabaseInstance {
  AppDataBase? database;

  AppDataBase get getdatabase {
    if (database != null) {
      return database!;
    }
    database = AppDataBase();
    return database!;
  }
}
