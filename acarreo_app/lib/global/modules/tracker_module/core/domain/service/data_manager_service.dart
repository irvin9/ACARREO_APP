abstract class DataManagerService {
  Future<bool> update();
  Future<bool> get();
  Future<bool> hasPeddingTickes();
  Future<String?> readScanner();
}
