import 'package:acarreo_app/global/core/data/model/user_auth_model.dart';

abstract class StorageService {
  static const tokenKey = 'token';

  static const defaultValue = '';

  Future<void> saveUser(UserAuthModel user);

  Future<UserAuthModel> getCurrentUser();

  Future<String> getToken();

  Future<void> saveToken(String token);

  Future<String> readByKey(String key);

  Future<Map<String, String>> readAllValues();

  Future<void> deleteByKey(String key);

  Future<void> deleteAll();

  Future<void> writeByKey(String key, String value);
}
