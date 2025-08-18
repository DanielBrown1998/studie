import 'package:app/domain/models/task.dart';
import 'package:app/core/theme/theme.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TaskCard extends StatefulWidget {
  final Task task;
  double? width;
  bool flagShowDescription = false;
  Color borderColorCard = StudieTheme.primaryColor;
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
      child: TweenAnimationBuilder(
        duration: Duration(milliseconds: 350),
        tween: Tween<double>(begin: 1, end: widget.width),
        curve: Curves.linearToEaseOut,
        onEnd: () {},
        builder:
            (context, value, child) => Center(
              child: AnimatedSize(
                duration: Duration(milliseconds: 450),
                curve: Curves.linear,
                onEnd: () {
                  setState(() {
                    widget.width = 1;
                    if (widget.borderColorCard != StudieTheme.primaryColor) {
                      widget.borderColorCard = StudieTheme.primaryColor;
                    } else {
                      widget.borderColorCard = StudieTheme.secondaryColor;
                    }
                  });
                },
                reverseDuration: Duration(milliseconds: 300),
                child: Card(
                  shadowColor: theme.primaryColor,
                  shape: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: (3 + (widget.width ?? 0.0)) * (2 - widget.width!),
                      color: widget.borderColorCard,
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(14),
                      topRight: Radius.circular(14),
                    ),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    shape: OutlineInputBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(18),
                        topRight: Radius.circular(18),
                      ),
                    ),
                    child: child,
                  ),
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
            widget.task.checked = !widget.task.checked;
            setState(() {});
          },
          onLongPress: () {
            widget.flagShowDescription = !widget.flagShowDescription;
            setState(() {
              widget.width = 0;
            });
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              children: [
                Row(
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
                Visibility(
                  visible: widget.flagShowDescription,
                  child: Column(
                    children: [
                      Text(
                        widget.task.description,
                        style: theme.textTheme.bodyMedium,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          IconButton(
                            onPressed: () {
                              //here update data in task
                            },
                            icon: Icon(Icons.refresh),
                          ),
                          IconButton(
                            onPressed: () {
                              //here delete from database
                            },
                            icon: Icon(Icons.delete),
                          ),
                          IconButton(
                            onPressed: () {
                              //here go a pomodoro
                            },
                            icon: Icon(Icons.access_alarm),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
