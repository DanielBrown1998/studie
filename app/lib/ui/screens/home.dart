import 'package:app/ui/controllers/controller_taks.dart';
import 'package:app/ui/screens/tasks/logic/tasks_binding.dart';
import 'package:app/ui/screens/tasks/page/tasks.dart';
import 'package:app/ui/core/components/app_bar.dart';
import 'package:app/ui/core/components/menu_card.dart';
import 'package:app/source/database/database.dart';
import 'package:app/utils/helpers/database_instance.dart';
import 'package:app/utils/helpers/days_week.dart';
import 'package:app/ui/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});
  final DatabaseInstance databaseInstance = DatabaseInstance();
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late double _op;
  @override
  void initState() {
    _op = 0;
    awaitAndShowMenuCard();
    super.initState();
    AppDataBase database = widget.databaseInstance.getdatabase;
    for (AllWeekDays weekday in AllWeekDays.values) {
      Get.putAsync(() async {
        final controller = ControllerTask(database: database);
        await controller.initializeController(name: weekday.nome);
        return controller;
      }, tag: weekday.nome);
    }
  }

  void awaitAndShowMenuCard() async {
    await Future.delayed(Duration(milliseconds: 1500));
    setState(() {
      _op = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: StudieAppBar.appBar,
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              StudieTheme.primaryColor,
              StudieTheme.terciaryColor,
              StudieTheme.whiteSmoke,
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                child: Text(
                  "Aqui voce pode planejar sua semana com facilidade".tr,
                  style: theme.textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: GridView(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    childAspectRatio: 1,
                    mainAxisSpacing: 20,
                  ),
                  children: [
                    AnimatedOpacity(
                      opacity: _op,
                      duration: Duration(seconds: 1),
                      curve: Curves.easeInCubic,
                      child: MenuCard(
                        function: () {
                          Get.to(
                            TasksScreen(),
                            binding: TasksBinding(),
                            curve: Curves.easeInOut,
                            duration: Duration(milliseconds: 500),
                            transition: Transition.downToUp,
                          );
                        },
                        description: "Tarefas",
                        icon: Icons.task_alt,
                        duration: 1,
                      ),
                    ),
                    AnimatedOpacity(
                      duration: Duration(seconds: 1),
                      opacity: _op,
                      curve: Curves.easeInCubic,
                      child: MenuCard(
                        function: () {},
                        description: "Config",
                        icon: Icons.settings,
                        duration: 1,
                      ),
                    ),
                    AnimatedOpacity(
                      opacity: _op,
                      duration: Duration(milliseconds: 1500),
                      curve: Curves.easeInCubic,
                      child: MenuCard(
                        function: () {},
                        description: "dicas",
                        icon: Icons.wb_incandescent_rounded,
                        duration: 1,
                      ),
                    ),
                    AnimatedOpacity(
                      opacity: _op,
                      duration: Duration(milliseconds: 1750),
                      curve: Curves.easeInCubic,
                      child: MenuCard(
                        function: () {},
                        description: "login",
                        icon: Icons.login,
                        duration: 1,
                      ),
                    ),
                    AnimatedOpacity(
                      opacity: _op,
                      duration: Duration(milliseconds: 1750),
                      curve: Curves.easeInCubic,
                      child: MenuCard(
                        function: () {},
                        description: "Pomodoro",
                        icon: Icons.apple,
                        duration: 1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButton: FloatingActionButton.extended(
        elevation: null,
        isExtended: true,
        backgroundColor: theme.primaryColor,
        label: Icon(Icons.help_outline_outlined, color: StudieTheme.whiteSmoke),
        onPressed: () {},
        splashColor: theme.primaryColorLight,
      ),
    );
  }
}
