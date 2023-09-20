import 'dart:async';

import 'package:acarreo_app/global/core/domain/service/local_storage_service.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

class HiveLocalStorageService extends LocalStorageService<Box<StorageObject>> {
  HiveLocalStorageService() {
    _init();
  }

  Future<void> _init() async {
    final directory = await getApplicationSupportDirectory();
    await Hive.initFlutter(directory.path);
  }

  @override
  Future<void> deleteItem(String key) async {
    final store = await storage();
    store.delete(key);
  }

  @override
  Future<bool> dispose() async {
    await Hive.close();
    return true;
  }

  @override
  Future<StorageObject?> getByKey(String key) async {
    final store = await storage();
    return store.get(key);
  }

  @override
  Future<List<StorageObject>> getItems() async {
    final store = await storage();
    final items = store.values.toList();
    return items;
  }

  @override
  Future<bool> init(String storageName) async {
    setStorageName = storageName;
    return true;
  }

  @override
  Future<void> saveBykey(String key, item) async {
    final store = await storage();
    await store.put(key, item);
  }

  @override
  Future<void> saveItems(List<StorageObject> items) async {
    final store = await storage();
    for (StorageObject item in items) {
      assert(item['id'] != null);
      store.put(item['id'], item);
    }
  }

  @override
  Future<Box<StorageObject>> storage() async {
    final box = await Hive.openBox<StorageObject>(storageName);
    return box;
  }

  @override
  Future<bool> clearAllStorage() async {
    await Hive.deleteFromDisk();
    return true;
  }
}
