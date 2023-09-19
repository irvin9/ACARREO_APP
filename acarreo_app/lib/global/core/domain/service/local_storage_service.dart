abstract class LocalStorageService<S, I, K> {
  Future<bool> init();

  Future<S> storage();

  Future<void> saveBykey(String key, I item);

  Future<void> saveItems(String id, List<I> items);

  Future<void> deleteItem(String key);

  Future<K?> getByKey(String key);

  Future<void> dispose();
}
