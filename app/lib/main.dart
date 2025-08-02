import 'package:app/domain/models/task.dart';
import 'package:app/screens/home.dart';
import 'package:app/services/database.dart';
import 'package:app/utils/helpers/days_week.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final AppDataBase appDataBase = AppDataBase();

  final task = Task(
    timeStart: 8,
    description: 'estudar flutter',
    discipline: "FLutter",
    daysWeek: AllDaysWeek.segundaFeira.name,
  );

  await appDataBase.createTask(task: task);

  List<Task> list = await appDataBase.getTasksByDaysWeek(
    daysWeek: AllDaysWeek.segundaFeira.name,
  );
  print(list);
  for (Task task in list) {
    print(task);
    await appDataBase.deleteTask(task: task);
  }

  runApp(const StudieApp());
}

class StudieApp extends StatelessWidget {
  const StudieApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const HomePage(),
    );
  }
}
