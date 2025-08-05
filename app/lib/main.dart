import 'package:app/screens/home.dart';
import 'package:app/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(StudieApp());
}

class StudieApp extends StatelessWidget {
  const StudieApp({super.key});

  @override
  Widget build(BuildContext context) {
    //start my controller
    return GetMaterialApp(
      title: 'Studie',
      theme: StudieTheme.theme,
      home: HomePage(),
    );
  }
}
