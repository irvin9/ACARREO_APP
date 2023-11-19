import 'dart:async';

import 'package:acarreo_app/global/core/acarreo_core_module.dart';
import 'package:acarreo_app/global/core/data/service/preferences_app_storage.dart';

class FirstLocationGuard extends RouteGuard {
  @override
  String? get redirectTo => GlobalRoutesApp.previewCurrentLocationTravelRoute;

  @override
  FutureOr<bool> canActivate(String path, ParallelRoute route) async {
    final existFirstLocation = await Modular.get<AppPreferencesStorage>()
        .getDataScreen('first-screen');
    return existFirstLocation == null;
  }
}
