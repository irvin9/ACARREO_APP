abstract class DataManagerService {
  Future<bool> update();
  Future<bool> get();
  Future<bool> hasPendingTickes();
  Future<String?> readScanner();
}
