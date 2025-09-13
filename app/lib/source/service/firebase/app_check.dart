import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter/foundation.dart' as foundation;

class AppCheck {
  FirebaseAppCheck get firebaseAppCheck => FirebaseAppCheck.instance;
  void initializeAppCheck() async {
    firebaseAppCheck.setTokenAutoRefreshEnabled(true);
    await firebaseAppCheck.activate(
      webProvider: ReCaptchaV3Provider('recaptcha-v3-site-key'),
      androidProvider:
          foundation.kDebugMode
              ? AndroidProvider.debug
              : AndroidProvider.playIntegrity,
    );
  }
}
