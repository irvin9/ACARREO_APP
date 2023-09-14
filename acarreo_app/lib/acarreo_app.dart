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
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1E293B),
          brightness: Brightness.dark,
        ),
      ),
    );
  }
}
