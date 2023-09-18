import 'package:acarreo_app/global/core/acarreo_core_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AcarreoApp extends StatelessWidget {
  final String initialRoute;

  const AcarreoApp({
    super.key,
    required this.initialRoute,
  });

  @override
  Widget build(BuildContext context) {
    Modular.setInitialRoute(initialRoute);
    return MaterialApp.router(
      routerConfig: Modular.routerConfig,
      title: 'Acarreo App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        fontFamily: 'Poppins',
      ),
    );
  }
}
