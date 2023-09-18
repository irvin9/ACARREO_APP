abstract class ScanNfcRepository {
  Future<bool> isSupported();
  Future<String?> startSession();
  void stopSession();
}
