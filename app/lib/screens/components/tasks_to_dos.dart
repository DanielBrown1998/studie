import 'package:app/domain/models/task.dart';
import 'package:app/screens/components/task_card.dart';
import 'package:app/core/utils/helpers/days_week.dart';
import 'package:app/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/controller_taks.dart';

class TasksToDos extends StatelessWidget {
  final AllWeekDays weekDays;
  final int index;
  const TasksToDos({super.key, required this.weekDays, required this.index});

  @override
  Widget build(BuildContext context) {
    final tasks = Get.find<ControllerTask>(tag: weekDays.nome);
    final size = MediaQuery.sizeOf(context);
    final theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Center(
          child: Icon(Icons.arrow_back_ios_new, color: StudieTheme.whiteSmoke),
        ),
        Flexible(
          child: Card(
            shape: OutlineInputBorder(
              gapPadding: 4,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              borderSide: BorderSide(color: StudieTheme.primaryColor, width: 2),
            ),
            shadowColor: StudieTheme.secondaryColor,
            color: Colors.transparent,
            elevation: 12,
            child: SizedBox(
              height: size.height * 0.6,
              width: size.width * .8,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Obx(() {
                  List<Task> allTasksThisWeekDay = tasks.tasks;
                  if (allTasksThisWeekDay.isEmpty) {
                    return Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.no_cell_rounded,
                          color: Colors.red,
                          size: 60,
                        ),
                        Text(
                          "Sem tarefa para esse dia da semana",
                          textAlign: TextAlign.center,
                          style: theme.textTheme.titleLarge,
                        ),
                      ],
                    );
                  }
                  return ListView.builder(
                    padding: EdgeInsets.only(left: 8, right: 8),
                    itemCount: allTasksThisWeekDay.length,
                    itemBuilder: (context, index) {
                      return TaskCard(
                        task: allTasksThisWeekDay[index],
                        controllerTask: tasks,
                      );
                    },
                  );
                }),
              ),
            ),
          ),
        ),
        Center(
          child: Icon(Icons.arrow_forward_ios, color: StudieTheme.whiteSmoke),
        ),
      ],
    );
  }
}
