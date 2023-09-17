import 'dart:async';

import 'package:acarreo_app/global/core/domain/service/storage_service.dart';
import 'package:acarreo_app/global/core/routes/global_routes_app.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SessionGuard extends RouteGuard {
  SessionGuard() : super(redirectTo: GlobalRoutesApp.registerTravelRoute);

  @override
  FutureOr<bool> canActivate(String path, ParallelRoute route) async {
    final isActiveSession =
        (await Modular.get<StorageService>().getToken()).isNotEmpty;
    return !isActiveSession;
  }
}
