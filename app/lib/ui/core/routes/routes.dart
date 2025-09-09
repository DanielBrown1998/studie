import 'package:app/ui/screens/tasks/logic/tasks_binding.dart';
import 'package:app/ui/screens/tasks/page/tasks.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

goToTaskScreen() => Get.to(
  TasksScreen(),
  binding: TasksBinding(),
  curve: Curves.easeInOut,
  duration: Duration(milliseconds: 500),
  transition: Transition.downToUp,
);
goOffAllTaskScreen() => Get.offAll(
  TasksScreen(),
  binding: TasksBinding(),
  curve: Curves.easeInOut,
  duration: Duration(milliseconds: 500),
  transition: Transition.downToUp,
);
