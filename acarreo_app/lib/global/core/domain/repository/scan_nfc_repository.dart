abstract class ScanNfcRepository {
  Future<bool> isSupported();
  Future<String?> startSession();
  Future<void> stopSession();

  Future<bool> writeNfcData(Map<String, dynamic> data);
  Future<Map<String, dynamic>?> readNfcData();
}
