import 'dart:ui';

import 'package:app/firebase_options.dart';
import 'package:app/ui/screens/home.dart';
import 'package:app/ui/core/theme/theme.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  //initializing firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Initialize Firebase App Check
  FirebaseAppCheck firebaseAppCheck = FirebaseAppCheck.instance;
  await firebaseAppCheck.activate(
    // Para web, você precisará configurar o reCAPTCHA v3 no console do Firebase.
    webProvider: ReCaptchaV3Provider(
      'recaptcha-v3-site-key',
    ), // Substitua pela sua chave se for usar na web
    androidProvider:
        kDebugMode ? AndroidProvider.debug : AndroidProvider.playIntegrity,
  );

  //initialize Firebase Crashlytics
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

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
      transitionDuration: Duration(milliseconds: 650),
    );
  }
}
