import 'package:app/ui/controllers/controller_taks.dart';
import 'package:app/source/models/task.dart';
import 'package:app/ui/core/components/create_task.dart';
import 'package:app/ui/core/components/default_dialog.dart';
import 'package:app/utils/helpers/days_week.dart';
import 'package:app/ui/core/theme/theme.dart';
import 'package:app/ui/core/components/task_card.dart';
import 'package:app/ui/core/components/tasks_to_dos.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  late int weekdayByDateTime;
  AllWeekDays? weekday;
  ControllerTask? controller;
  List<Widget> toDos = [
    Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Icon(Icons.arrow_drop_up, color: StudieTheme.whiteSmoke),
            ),
            Card(
              shape: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide(
                  width: 2,
                  color: StudieTheme.secondaryColor,
                ),
              ),
              elevation: 20,
              shadowColor: StudieTheme.secondaryColor,
              margin: EdgeInsets.only(bottom: 16, top: 16),
              color: StudieTheme.terciaryColor,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: 10,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TaskCard(
                        task: Task(
                          timeStart: 00,
                          description: "aqui ficara a descricao da sua tarefa",
                          discipline: "titulo",
                          daysWeek: AllWeekDays.domingo.nome,
                        ),
                      ),
                    ),
                    Wrap(
                      spacing: 10,
                      direction: Axis.vertical,
                      alignment: WrapAlignment.spaceBetween,
                      children: [
                        Chip(
                          label: Text(
                            "suas tarefas estao armazenadas aqui!",
                            style: StudieTheme.textTheme.displaySmall,
                          ),
                        ),
                        Chip(
                          label: Text("aperte para marcar como concluido"),
                          labelStyle: StudieTheme.textTheme.displaySmall,
                        ),
                        Chip(
                          label: Text(
                            "pressione para ver a descricao",
                            style: StudieTheme.textTheme.displaySmall,
                          ),
                        ),
                        Chip(
                          label: Text(
                            "utilize o exemplo para testes",
                            style: StudieTheme.textTheme.displaySmall,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Center(
              child: Icon(Icons.arrow_drop_down, color: StudieTheme.whiteSmoke),
            ),
          ],
        ),
      ),
    ),
  ];

  void initializeDaysAndTaksofDays() {
    weekdayByDateTime = DateTime.now().weekday;
    for (int i = 1; i <= 7; i++) {
      weekday = getWeekdayByNumber(i);
      toDos.add(TasksToDos(weekDays: weekday!, index: i));
    }
    weekday = getWeekdayByNumber(weekdayByDateTime);
  }

  @override
  void initState() {
    initializeDaysAndTaksofDays();
    super.initState();
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
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: StudieTheme.primaryColor,
        centerTitle: true,
        foregroundColor: StudieTheme.primaryColor,
        surfaceTintColor: StudieTheme.primaryColor,
        elevation: 10,
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
      body: Stack(
        children: [
          SizedBox(
            height: double.maxFinite,
            width: double.maxFinite,
            child: Image.asset(
              "assets/images/background.jpg",
              fit: BoxFit.cover,
            ),
          ),
          SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                (weekday != null)
                    ? Text(weekday!.nome, style: theme.textTheme.titleMedium)
                    : Text("Orientacoes", style: theme.textTheme.titleMedium),
                Center(
                  child: CarouselSlider(
                    items: toDos,
                    options: CarouselOptions(
                      autoPlay: false,
                      // reverse: true,
                      viewportFraction: 1,
                      onPageChanged: (index, reason) {
                        setState(() {
                          if (index != 0) {
                            weekday = getWeekdayByNumber(index);
                          } else {
                            weekday = null;
                          }
                        });
                      },
                      height: size.height * .8,
                      disableCenter: false,
                      aspectRatio: 1 / (size.width / size.height),
                      initialPage: weekdayByDateTime,
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton:
          (weekday != null) ? CreateTask(weekday: weekday!.nome).show : null,
    );
  }
}
