import 'package:app/controllers/controller_taks.dart';
import 'package:app/domain/models/task.dart';
import 'package:app/screens/widgets/default_dialog.dart';
import 'package:app/utils/helpers/days_week.dart';
import 'package:app/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  late int weekdayByDateTime;
  late AllWeekDays weekday;
  ControllerTask? controller;
  @override
  void initState() {
    super.initState();
    weekdayByDateTime = DateTime.now().weekday;
    weekday = getWeekdayByNumber(weekdayByDateTime);
    controller = Get.find<ControllerTask>(tag: weekday.nome);
    print(controller!.name.value);
    for (Task item in controller!.tasks) {
      print(item);
    }
  }

  deleteDataInCloud() async {
    final bool? confirm = await DefaultDialog.dialog(
      confirmText: "sim",
      cancelText: "nao",
      middleText: "deseja apagar os dados da nuvem?",
      titleText: "Remover Dados",
    );
    if (confirm == true) {
      // TODO implements a function to remove firebase data
    }
  }

  syncDataInCloud() async {}

  saveDataInCLoud() async {}

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: StudieTheme.primaryColor,
        centerTitle: true,
        foregroundColor: StudieTheme.primaryColor,
        surfaceTintColor: StudieTheme.primaryColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: null,
        title: Text("Tarefas", style: theme.textTheme.titleLarge),
        actions: [
          PopupMenuButton(
            onSelected: (value) {
              switch (value) {
                case "delete":
                  deleteDataInCloud();
                  break;
                case "save":
                  saveDataInCLoud();
                  break;
                case "sync":
                  syncDataInCloud();
                  break;
              }
            },
            icon: Icon(Icons.cloud, color: StudieTheme.whiteSmoke),
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  value: "save",
                  child: ListTile(
                    leading: Icon(Icons.upload),
                    title: Text(
                      "salvar tarefas",
                      style: theme.textTheme.bodyMedium,
                    ),
                  ),
                ),
                PopupMenuItem(
                  value: "sync",
                  child: ListTile(
                    leading: Icon(Icons.sync),
                    title: Text(
                      "sincronizar tarefas",
                      style: theme.textTheme.bodyMedium,
                    ),
                  ),
                ),
                PopupMenuItem(
                  value: "delete",
                  child: ListTile(
                    leading: Icon(Icons.delete),
                    title: Text(
                      "deletar tarefas",
                      style: theme.textTheme.bodyMedium,
                    ),
                  ),
                ),
              ];
            },
          ),
        ],
      ),
      body: Container(
        height: double.maxFinite,
        decoration: BoxDecoration(color: StudieTheme.primaryColor),
      ),
    );
  }
}
