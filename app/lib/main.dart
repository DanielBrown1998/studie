import 'package:app/firebase_options.dart';
import 'package:app/ui/screens/home.dart';
import 'package:app/ui/core/theme/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  //initializing firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

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
      debugShowMaterialGrid: false,
      locale: Locale("pt", "BR"),
      defaultTransition: Transition.upToDown,
      onInit: () async {},
      transitionDuration: Duration(milliseconds: 750),
    );
  }
}
