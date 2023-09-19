import 'package:acarreo_app/global/core/domain/service/local_storage_service.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

typedef HiveLocalObject = Map<String, dynamic>;

class HiveLocalStorageService
    implements
        LocalStorageService<Box<HiveLocalObject>, HiveLocalObject,
            List<HiveLocalObject?>> {
  String? _storageName;

  @override
  Future<void> deleteItem(String key) async {
    final store = await storage();
    store.delete(key);
    store.close();
  }

  @override
  Future<bool> dispose() async {
    final store = await storage();
    store.close();
    return true;
  }

  @override
  Future<List<HiveLocalObject?>> getByKey(String key) async {
    final store = await storage();
    return store.values.toList();
  }

  @override
  Future<bool> init() async {
    final directory = await getApplicationSupportDirectory();
    await Hive.initFlutter(directory.path);
    return true;
  }

  @override
  Future<void> saveBykey(String key, item) async {
    final store = await storage();
    await store.put(key, item);
    store.close();
  }

  @override
  Future<void> saveItems(String id, List<HiveLocalObject> items) async {
    final store = await storage();
    for (HiveLocalObject item in items) {
      assert(item['id'] != null);
      store.put(item['id'], item);
    }
    store.close();
  }

  @override
  Future<Box<HiveLocalObject>> storage() async {
    assert(_storageName != null);
    return await Hive.openBox<HiveLocalObject>(_storageName!);
  }

  String get storageName {
    assert(_storageName != null);
    return _storageName!;
  }

  set setStorageName(String boxName) => _storageName = boxName;
}
