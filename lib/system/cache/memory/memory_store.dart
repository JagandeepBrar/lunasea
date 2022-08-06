import 'package:lunasea/core.dart';

class LunaMemoryStore {
  LunaMemoryStore._();

  static final Future<MemoryCacheStore> _store = newMemoryCacheStore();

  /// Returns a cache with the given ID.
  static Future<Cache> get({
    required String? id,
    required bool fresh,
    EvictionPolicy? evictionPolicy,
    ExpiryPolicy? expiryPolicy,
    int? maxEntries,
    KeySampler? sampler,
    EventListenerMode? eventListenerMode,
    Future<dynamic> Function(String)? cacheLoader,
  }) async {
    if (fresh) delete(id!);
    final store = await _store;
    return store.cache(
      name: id,
      sampler: sampler,
      evictionPolicy: evictionPolicy,
      maxEntries: maxEntries,
      expiryPolicy: expiryPolicy,
      cacheLoader: cacheLoader,
      eventListenerMode: eventListenerMode,
    );
  }

  /// Delete the cache from the store.
  /// If no cache ID is supplied, deletes all caches in the store.
  static Future<void> delete([String? id]) async {
    final store = await _store;
    if (id?.isEmpty ?? true) return store.deleteAll();
    return store.delete(id!);
  }

  /// Does a cache with the given ID exist?
  /// A cache "exists" if it has at least 1 key.
  static Future<bool> exists(String id) async {
    final store = await _store;
    int size = await store.size(id);
    return size != 0;
  }
}
