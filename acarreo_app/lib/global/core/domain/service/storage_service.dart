abstract class StorageService {
  static const tokenKey = 'token';

  static const defaultValue = '';

  Future<String> getToken();

  Future<void> saveToken(String token);

  Future<String> readByKey(String key);

  Future<Map<String, String>> readAllValues();

  Future<void> deleteByKey(String key);

  Future<void> deleteAll();

  Future<void> writeByKey(String key, String value);
}
