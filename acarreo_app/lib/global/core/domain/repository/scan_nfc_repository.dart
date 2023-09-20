abstract class ScanNfcRepository {
  Future<bool> isSupported();
  Future<String?> startSession();
  Future<void> stopSession();
}
