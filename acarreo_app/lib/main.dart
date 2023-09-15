import 'package:flutter/material.dart';
import 'package:acarreo_app/acarreo_app.dart';
import 'package:acarreo_app/global/acarreo_app_module.dart';
import 'package:acarreo_app/global/core/acarreo_core_module.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  GoogleFonts.config.allowRuntimeFetching = false;

  final String initialRoute = GlobalRoutesApp.authLoginRoute;

  runApp(
    ModularApp(
      module: AcarreoAppModule(),
      child: AcarreoApp(initialRoute: initialRoute),
    ),
  );
}
