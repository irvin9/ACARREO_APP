import 'package:acarreo_app/global/core/constant/environments.dart';
import 'package:acarreo_app/global/core/domain/service/environment_service.dart';

class FlutterEnvironmentService implements EnviromentService {
  @override
  String get apiAuthUrl => const String.fromEnvironment(Environments.apiAuth);

  @override
  String get apiHostUrl => const String.fromEnvironment(Environments.apiHost);

  @override
  String get apiAuthVersion =>
      const String.fromEnvironment(Environments.apiAuthVersion);

  @override
  String get apiHostVersion =>
      const String.fromEnvironment(Environments.apiHostVersion);
}
