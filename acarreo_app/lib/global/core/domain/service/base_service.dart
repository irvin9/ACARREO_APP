abstract class BaseService<T> {
  Future<List<T>?> update();
  Future<List<T>?> get();
}
