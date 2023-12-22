import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:acarreo_app/global/core/data/model/user_auth_model.dart';
import 'package:acarreo_app/global/core/domain/service/storage_service.dart';

class FlutterStorageService implements StorageService {
  FlutterStorageService(this.storage);

  final FlutterSecureStorage storage;

  UserAuthModel? _currentUser;

  @override
  Future<void> deleteAll() async {
    return await storage.deleteAll();
  }

  @override
  Future<void> deleteByKey(String key) async {
    await storage.delete(key: key);
  }

  @override
  Future<UserAuthModel> getCurrentUser() async {
    final data = await storage.read(key: 'user') ?? '';
    return UserAuthModel.fromApiJson(data);
  }

  @override
  Future<String> getToken() async {
    return await readByKey(StorageService.tokenKey);
  }

  @override
  Future<void> loadData() async {
    _currentUser = await getCurrentUser();
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
  Future<void> saveUser(UserAuthModel user) async {
    final data = user.toLocalStorage();
    await writeByKey('user', data);
  }

  @override
  Future<void> writeByKey(String key, String value) async {
    await storage.write(key: key, value: value);
  }

  @override
  UserAuthModel get currentUser => _currentUser!;
}
