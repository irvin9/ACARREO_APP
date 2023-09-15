import 'dart:async';

import 'package:acarreo_app/global/core/domain/service/storage_service.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AuthGuard extends RouteGuard {
  @override
  FutureOr<bool> canActivate(String path, ParallelRoute route) async {
    final isLogged =
        (await Modular.get<StorageService>().getToken()).isNotEmpty;
    return isLogged;
  }
}
