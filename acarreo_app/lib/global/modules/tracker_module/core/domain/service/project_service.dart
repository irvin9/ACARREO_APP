import 'package:acarreo_app/global/core/domain/service/base_service.dart';

abstract class ProjectService<T> implements BaseService<T> {
  Future<T?> updateProject();

  Future<T?> getProject();
}
