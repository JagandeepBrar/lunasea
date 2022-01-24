import 'package:lunasea/core.dart';

class LunaMemoryStore {
  LunaMemoryStore._();

  static final MemoryCacheStore _store = newMemoryCacheStore();

  /// Returns a cache with the given ID.
  static Cache get({
    required String? id,
    required bool fresh,
    EvictionPolicy? evictionPolicy,
    ExpiryPolicy? expiryPolicy,
    int? maxEntries,
    KeySampler? sampler,
    EventListenerMode? eventListenerMode,
    Future<dynamic> Function(String)? cacheLoader,
  }) {
    if (fresh) delete(id!);
    return _store.cache(
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
    if (id?.isEmpty ?? true) return _store.deleteAll();
    return _store.delete(id!);
  }

  /// Does a cache with the given ID exist?
  /// A cache "exists" if it has at least 1 key.
  static Future<bool> exists(String id) async {
    int size = await _store.size(id);
    return size != 0;
  }
}
