import 'package:app/domain/models/task.dart';
import 'package:app/screens/widgets/task_card.dart';
import 'package:app/utils/helpers/days_week.dart';
import 'package:app/utils/theme/theme.dart';
import 'package:flutter/material.dart';

class TasksToDos extends StatelessWidget {
  final AllWeekDays weekDays;
  TasksToDos({super.key, required this.weekDays});

  //TODO cut this when controllerTask is implemented
  final Task task = Task(
    timeStart: 8,
    description: "contruindo a task screen",
    discipline: "Flutter",
    daysWeek: AllWeekDays.quartaFeira.nome,
  );

  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context);
    final media = MediaQuery.of(context);
    return Card(
      shape: OutlineInputBorder(
        gapPadding: 4,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        borderSide: BorderSide(color: StudieTheme.secondaryColor, width: 8),
      ),
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
    );
  }
}
