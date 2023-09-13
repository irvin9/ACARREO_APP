import 'package:acarreo_app/global/core/domain/service/storage_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class FlutterStorageService implements StorageService {
  const FlutterStorageService(this.storage);

  final FlutterSecureStorage storage;

  @override
  Future<void> deleteAll() async {
    return await storage.deleteAll();
  }

  @override
  Future<void> deleteByKey(String key) async {
    await storage.delete(key: key);
  }

  @override
  Future<String> getToken() async {
    return await readByKey(StorageService.tokenKey);
  }

  @override
  Future<Map<String, String>> readAllValues() async {
    return await storage.readAll();
  }

  @override
  Future<String> readByKey(String key) async {
    return (await storage.read(key: key)) ?? StorageService.defaultValue;
  }

  @override
  Future<void> saveToken(String token) async {
    await writeByKey(StorageService.tokenKey, token);
  }

  @override
  Future<void> writeByKey(String key, String value) async {
    await storage.write(key: key, value: value);
  }
}
