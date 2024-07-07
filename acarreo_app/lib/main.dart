import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:acarreo_app/acarreo_app.dart';
import 'package:acarreo_app/global/acarreo_app_module.dart';
import 'package:acarreo_app/global/core/acarreo_core_module.dart';

import 'firebase_options.dart';

void catchUnhandledExceptions(Object error, StackTrace? stack) {
  FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
  debugPrintStack(stackTrace: stack, label: error.toString());
}

void main() async {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      GoogleFonts.config.allowRuntimeFetching = false;

      final String initialRoute = GlobalRoutesApp.authLoginRoute;
      await HiveLocalStorageService.initStorage();
      runApp(
        ModularApp(
          module: AcarreoAppModule(),
          child: AcarreoApp(initialRoute: initialRoute),
        ),
      );
    },
    catchUnhandledExceptions,
  );
}
