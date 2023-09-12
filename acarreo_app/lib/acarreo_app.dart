import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AcarreoApp extends StatelessWidget {
  final String initialRoute;
  const AcarreoApp({super.key, this.initialRoute = '/'});

  @override
  Widget build(BuildContext context) {
    Modular.setInitialRoute(initialRoute);
    return MaterialApp.router(
      title: 'Acarreo App',
      routerConfig: Modular.routerConfig,
    );
  }
}
