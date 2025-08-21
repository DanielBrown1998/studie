import 'package:app/controllers/controller_taks.dart';
import 'package:app/domain/models/task.dart';
import 'package:app/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class TaskCard extends StatefulWidget {
  final Task task;
  double? width;
  final ControllerTask? controllerTask;
  bool flagShowDescription = false;
  Color borderColorCard = StudieTheme.primaryColor;
  TaskCard({super.key, required this.task, this.controllerTask, this.width});

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
  bool get mounted => super.mounted && widget.width != null;

  @override
  void dispose() {
    widget.width = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ControllerTask? controller = widget.controllerTask;
    final theme = Theme.of(context);
    final size = MediaQuery.sizeOf(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TweenAnimationBuilder(
        duration: Duration(milliseconds: 350),
        tween: Tween<double>(begin: 1, end: widget.width ?? 1),
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
                      width: (3 + (widget.width ?? 0.0)) * (2 - (widget.width ?? 1.0)),
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
          onTap: () async {
            //check is here
            widget.task.checked = !widget.task.checked;
            await controller!.setTaskChecked(task: widget.task);
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
                              //here update data screen in task
                            },
                            icon: Icon(Icons.refresh),
                          ),
                          IconButton(
                            onPressed: () async {
                              bool delete = await Get.dialog(
                                Container(
                                  constraints: BoxConstraints(
                                    maxHeight: 500,
                                    minHeight: 350,
                                    minWidth: 230,
                                    maxWidth: 400,
                                  ),
                                  height: size.height / 3,
                                  width: size.width * .8,
                                  decoration: BoxDecoration(
                                    color: StudieTheme.whiteSmoke.withAlpha(
                                      160,
                                    ),
                                    shape: BoxShape.rectangle,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(
                                        Icons.remove_circle_outline,
                                        color: Colors.red,
                                        size: 50,
                                      ),
                                      Text(
                                        "Remover ${widget.task.discipline}?",
                                        style: theme.textTheme.bodyLarge,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          ElevatedButton(
                                            onPressed: () {
                                              Get.back(result: false);
                                            },
                                            style: ButtonStyle(
                                              iconColor:
                                                  WidgetStateProperty.all(
                                                    Colors.red,
                                                  ),
                                              iconSize: WidgetStateProperty.all(
                                                32,
                                              ),
                                              backgroundColor:
                                                  WidgetStateProperty.all(
                                                    StudieTheme.whiteColor,
                                                  ),
                                            ),
                                            child: Icon(Icons.delete),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              Get.back(result: true);
                                            },
                                            style: ButtonStyle(
                                              iconColor:
                                                  WidgetStateProperty.all(
                                                    const Color.fromARGB(
                                                      255,
                                                      47,
                                                      112,
                                                      49,
                                                    ),
                                                  ),
                                              iconSize: WidgetStateProperty.all(
                                                32,
                                              ),
                                              backgroundColor:
                                                  WidgetStateProperty.all(
                                                    StudieTheme.whiteColor,
                                                  ),
                                            ),
                                            child: Icon(Icons.check),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                transitionCurve: Curves.decelerate,
                                transitionDuration: Duration(milliseconds: 500),
                              );
                              if (delete) {
                                await controller!.deleteTask(task: widget.task);
                              }
                            },
                            icon: Icon(Icons.delete, color: Colors.red),
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
