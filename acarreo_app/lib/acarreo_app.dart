import 'package:acarreo_app/global/core/acarreo_core_module.dart';
import 'package:acarreo_app/global/core/data/service/flutter_blue_service.dart';
import 'package:acarreo_app/global/core/domain/cubit/app_cubit_observer.dart';
import 'package:flutter/material.dart';

class AcarreoApp extends StatelessWidget {
  final String initialRoute;

  const AcarreoApp({
    super.key,
    required this.initialRoute,
  });

  @override
  Widget build(BuildContext context) {
    Modular.setInitialRoute(initialRoute);
    Modular.setObservers([AppRouteObserver()]);
    Modular.get<FlutterBlueService>().checkPermission();
    Bloc.observer = AppCubitObserver();
    return MaterialApp.router(
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
      title: 'Acarreo App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        fontFamily: 'Poppins',
        appBarTheme: const AppBarTheme(
          color: Color(0xFF384596),
        ),
      ),
    );
  }
}
