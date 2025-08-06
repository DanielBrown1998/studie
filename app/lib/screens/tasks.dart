import 'package:app/domain/models/task.dart';
import 'package:app/screens/widgets/default_dialog.dart';
import 'package:app/screens/widgets/task_card.dart';
import 'package:app/utils/helpers/days_week.dart';
import 'package:app/utils/theme/theme.dart';
import 'package:flutter/material.dart';

class TasksScreen extends StatelessWidget {
  TasksScreen({super.key});

  //TODO cut this when controllerTask is implemented
  final Task task = Task(
    timeStart: 8,
    description: "contruindo a task screen",
    discipline: "Flutter",
    daysWeek: AllWeekDays.quartaFeira.nome,
  );

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
    final media = MediaQuery.of(context);
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
        decoration: BoxDecoration(color: StudieTheme.primaryColor),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 10,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AllWeekDays.quartaFeira.nome,
              style: theme.textTheme.titleLarge,
            ),
            Center(
              child: Card(
                shape: OutlineInputBorder(
                  gapPadding: 4,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                elevation: 32,
                shadowColor: StudieTheme.whiteSmoke,
                color: StudieTheme.whiteColor,
                child: SizedBox(
                  height: media.size.height * 0.55,
                  width: media.size.width * .75,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    //TODO replace this when controllerTask was implemented
                    child: ListView.builder(
                      padding: EdgeInsets.only(left: 8, right: 8),
                      itemCount: 14,
                      itemBuilder: (context, index) {
                        return TaskCard(task: task);
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
