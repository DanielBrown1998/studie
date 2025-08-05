import 'package:app/utils/theme/theme.dart';
import 'package:flutter/material.dart';

class StudieAppBar {
  static AppBar appBar = AppBar(
    actions: [],
    centerTitle: true,
    backgroundColor: StudieTheme.primaryColor,
    title: Text("Studie", style: StudieTheme.textTheme.titleLarge),
  );
}
