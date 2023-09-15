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
      theme: ThemeData.light(
        useMaterial3: true,
      ),
      darkTheme: ThemeData.dark(useMaterial3: true),
    );
  }
}
