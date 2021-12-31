import 'package:lunasea/core.dart';

class LunaMemoryStore {
  LunaMemoryStore._();

  static final MemoryStore _store = newMemoryStore();
  static Future<void> clear() async => _store.deleteAll();

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
    if (fresh) remove(id!);
    return _store.cache(
      cacheName: id,
      sampler: sampler,
      evictionPolicy: evictionPolicy,
      maxEntries: maxEntries,
      expiryPolicy: expiryPolicy,
      cacheLoader: cacheLoader,
      eventListenerMode: eventListenerMode,
    );
  }

  /// Remove a cache from the store.
  static Future<void> remove(String id) async => _store.delete(id);

  /// Does a cache with the given ID exist?
  ///
  /// A cache "exists" if it has at least 1 key.
  static Future<bool> exists(String id) async {
    int size = await _store.size(id);
    return size != 0;
  }
}
