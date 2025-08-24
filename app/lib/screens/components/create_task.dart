import 'package:app/controllers/controller_taks.dart';
import 'package:app/core/theme/theme.dart';
import 'package:app/domain/models/task.dart';
import 'package:app/screens/components/getsnackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

//TODO refactor create task
class CreateTask {
  final String weekday;
  CreateTask({required this.weekday});

  FloatingActionButton get show {
    final controller = Get.find<ControllerTask>(tag: weekday);
    return FloatingActionButton.small(
      backgroundColor: Colors.amber,
      elevation: 20,
      splashColor: StudieTheme.secondaryColor,
      child: Icon(Icons.add_task, color: StudieTheme.whiteSmoke, size: 30),
      onPressed: () async {
        final localFormKey = GlobalKey<FormState>();
        final disciplina = TextEditingController();
        final hourInitial = TextEditingController();
        final hourEnd = TextEditingController();
        final description = TextEditingController();

        Task? task = await Get.dialog(
          LayoutBuilder(
            builder:
                (context, constraints) => SingleChildScrollView(
                  child: Container(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                      minWidth: constraints.maxWidth,
                    ),
                    child: Material(
                      color: StudieTheme.primaryColor,
                      child: Form(
                        key: localFormKey,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 16.0,
                            horizontal: 24.0,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                weekday,
                                style: StudieTheme.textTheme.titleLarge,
                              ),
                              Text(
                                "insira os dados da tarefa",
                                style: StudieTheme.textTheme.titleMedium,
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                  labelText: "disciplina",
                                  labelStyle: StudieTheme.textTheme.titleSmall,
                                ),
                                controller: disciplina,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Informe a disciplina';
                                  }
                                  if (value.length > 12) {
                                    return 'Menos de 12 caracteres';
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.name,
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                  labelText: "hora inicial",
                                  labelStyle: StudieTheme.textTheme.titleSmall,
                                ),
                                controller: hourInitial,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Informe o horário inicial';
                                  }
                                  final hour = int.tryParse(value);
                                  if (hour == null || hour < 0 || hour > 23) {
                                    return 'Horário inicial inválido';
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.datetime,
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                  labelText: "hora final",
                                  labelStyle: StudieTheme.textTheme.titleSmall,
                                ),
                                controller: hourEnd,
                                validator: (value) {
                                  if (value != null) {
                                    final hour = int.tryParse(value);
                                    if (hour == null || hour < 0 || hour > 23) {
                                      return 'Horário final inválido';
                                    }
                                    if (hourInitial.text.isNotEmpty) {
                                      final start = int.tryParse(
                                        hourInitial.text,
                                      );
                                      if (start != null && hour <= start) {
                                        return 'Horário final deve ser maior que o inicial';
                                      }
                                    }
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.datetime,
                              ),
                              TextFormField(
                                controller: description,
                                decoration: InputDecoration(
                                  labelText: "descricao",
                                  labelStyle: StudieTheme.textTheme.titleSmall,
                                ),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Informe a descrição';
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.name,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      if (localFormKey.currentState != null &&
                                          localFormKey.currentState!
                                              .validate()) {
                                        Get.back(
                                          result: Task(
                                            timeStart: int.parse(
                                              hourInitial.text,
                                            ),
                                            description: description.text,
                                            discipline: disciplina.text,
                                            daysWeek: weekday,
                                          ),
                                        );
                                      }
                                    },
                                    child: Icon(Icons.add_task),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      if (localFormKey.currentState != null &&
                                          localFormKey.currentState!
                                              .validate()) {
                                        Get.back(result: null);
                                      }
                                    },
                                    child: Icon(Icons.add_task),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
          ),
          name: weekday,
        );
        if (task != null) {
          final SnackbarController controllerCreateTask = Get.showSnackbar(
            GetSnackBarStudie(
              icon: Icons.arrow_circle_left_rounded,
              message: "criando tarefa...",
            ).snackbarStudie,
          );
          controllerCreateTask.show();
          controller.createTask(task: task).then((value) {
            controllerCreateTask.close();
            if (value > 0) {
              Get.showSnackbar(
                GetSnackBarStudie(
                  icon: Icons.create,
                  message: "tarefa criada com sucesso!",
                ).snackbarStudie,
              );
            } else {
              Get.showSnackbar(
                GetSnackBarStudie(
                  icon: Icons.error,
                  message: "Erro ao criar tarefa!",
                ).snackbarStudie,
              );
            }
          });
        }
      },
    );
  }
}
