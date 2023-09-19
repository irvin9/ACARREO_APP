typedef StorageObject = Map<String, dynamic>;

abstract class LocalStorageService<S> {
  Future<bool> init();

  Future<S> storage();

  Future<void> saveBykey(String key, StorageObject item);

  Future<void> saveItems(List<StorageObject> items);

  Future<void> deleteItem(String key);

  Future<List<StorageObject>> getItems();

  Future<StorageObject?> getByKey(String key);

  Future<void> dispose();
}
