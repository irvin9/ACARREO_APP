abstract class ScanNfcRepository {
  Future<bool> isSupported();
  Future<String?> startSession();
  Future<void> stopSession();

  Future<void> writeNfcData(Map<String, dynamic> data);
  Future<Map<String, dynamic>?> readNfcData();
}
