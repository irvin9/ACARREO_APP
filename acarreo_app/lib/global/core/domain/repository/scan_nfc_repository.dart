abstract class ScanNfcRepository {
  Future<bool> isSupported();
  Future<String?> startSession({int timeout = 30});
  Future<void> stopSession();

  Future<bool> writeNfcData(Map<String, dynamic> data);
  Future<Map<String, dynamic>?> readNfcData();
}
