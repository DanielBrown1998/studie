import 'package:app/domain/models/task.dart';
import 'package:app/core/theme/theme.dart';
import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  const TaskCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Dismissible(
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {},
      background: Container(
        color: Colors.red,
        child: const Padding(
          padding: EdgeInsets.only(right: 16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [Icon(Icons.delete)],
          ),
        ),
      ),
      key: Key(task.uid.toString()),
      child: Center(
        child: Material(
          color: Colors.transparent,
          child: Card(
            shadowColor: theme.primaryColor,
            shape: OutlineInputBorder(
              borderSide: BorderSide(
                width: 2,
                color: StudieTheme.secondaryColor,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(18),
                topRight: Radius.circular(18),
              ),
            ),
            child: InkWell(
              onTap: () {
                //check is here
              },
              onLongPress: () {
                //update is here
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      task.timeStart.toString(),
                      style: theme.textTheme.bodyMedium,
                    ),
                    Text(task.discipline, style: theme.textTheme.bodyMedium),
                    Checkbox(
                      value: task.checked,
                      onChanged: (value) {},
                      shape: CircleBorder(
                        side: BorderSide(
                          width: 2,
                          color: StudieTheme.secondaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
