typedef StorageObject = Map<dynamic, dynamic>;

abstract class LocalStorageService<S> {
  String? _storageName;

  String get storageName {
    assert(_storageName != null,
        '${runtimeType.toString()}: Set Storage name with setStorageName()');
    return _storageName!;
  }

  set setStorageName(String storageName) => _storageName = storageName;

  Future<bool> init(String storageName);

  Future<S> storage();

  Future<void> saveBykey(String key, StorageObject item);

  Future<void> saveItems(List<StorageObject> items);

  Future<void> deleteItem(String key);

  Future<List<StorageObject>> getItems();

  Future<StorageObject?> getByKey(String key);

  Future<bool> clearAllStorage();

  Future<void> dispose();
}
