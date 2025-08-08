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
    // final theme = Theme.of(context);
    final tasks = Get.find<ControllerTask>(tag: weekDays.nome);
    final media = MediaQuery.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Center(child: Icon(Icons.arrow_drop_up, color: StudieTheme.whiteSmoke)),
        Card(
          shape: OutlineInputBorder(
            gapPadding: 4,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            borderSide: BorderSide(color: StudieTheme.secondaryColor, width: 8),
          ),
          shadowColor: StudieTheme.secondaryColor,
          color: StudieTheme.primaryColor,
          elevation: 12,
          child: SizedBox(
            height: media.size.height * 0.55,
            width: media.size.width * .75,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                padding: EdgeInsets.only(left: 8, right: 8),
                itemCount: tasks.tasks.length,
                itemBuilder: (context, index) {
                  return TaskCard(task: tasks.tasks[index]);
                },
              ),
            ),
          ),
        ),
        Center(
          child: Icon(Icons.arrow_drop_down, color: StudieTheme.whiteSmoke),
        ),
      ],
    );
  }
}
