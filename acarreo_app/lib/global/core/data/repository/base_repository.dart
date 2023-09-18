import 'package:acarreo_app/global/core/acarreo_core_module.dart';

abstract class BaseRepository {
  final EnviromentService environment = Modular.get<EnviromentService>();
  final HttpService http = Modular.get<HttpService>();
}
