import 'package:app/domain/models/task.dart';
import 'package:app/core/theme/theme.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TaskCard extends StatefulWidget {
  final Task task;
  double? width;
  TaskCard({super.key, required this.task, this.width});

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  @override
  void initState() {
    super.initState();
    widget.width = 1;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Dismissible(
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
        key: Key(widget.task.uid.toString()),
        child: TweenAnimationBuilder(
          duration: Duration(milliseconds: 350),
          tween: Tween<double>(begin: 1, end: widget.width),
          curve: Curves.bounceOut,
          onEnd: () {
            setState(() {
              widget.width = 1;
            });
          },
          builder:
              (context, value, child) => Center(
                child: Material(
                  color: Colors.transparent,
                  shape: OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(18),
                      topRight: Radius.circular(18),
                    ),
                  ),
                  child: Card(
                    shadowColor: theme.primaryColor,
                    shape: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 4 * (2 - widget.width!),
                        color: StudieTheme.secondaryColor,
                      ),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(14),
                        topRight: Radius.circular(14),
                      ),
                    ),
                    child: child,
                  ),
                ),
              ),
          child: InkWell(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(14),
              topRight: Radius.circular(14),
            ),
            onTap: () {
              //check is here
            },
            onLongPress: () {
              setState(() {
                widget.width = 0;
              });
              //update is here
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    widget.task.timeStart.toString(),
                    style: theme.textTheme.bodyMedium,
                  ),
                  Text(
                    widget.task.discipline,
                    style: theme.textTheme.bodyMedium,
                  ),
                  Checkbox(
                    value: widget.task.checked,
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
    );
  }
}
