import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

class CrashLytics {
  //initialize Firebase Crashlytics
  FirebaseCrashlytics get firebaseCrashlytics => FirebaseCrashlytics.instance;

  initializeCrashLytics() {
    FlutterError.onError = (errorDetails) {
      firebaseCrashlytics.recordFlutterFatalError(errorDetails);
    };
    PlatformDispatcher.instance.onError = (error, stack) {
      firebaseCrashlytics.recordError(error, stack, fatal: true);
      return true;
    };
  }
}
