import 'package:lunasea/system/cache/memory/memory_store.dart';
import 'package:lunasea/modules.dart';
import 'package:lunasea/vendor.dart';

class LunaMemoryCache {
  late String _key;
  late Cache _cache;

  LunaMemoryCache({
    required LunaModule module,
    required String id,
    EvictionPolicy evictionPolicy = const LruEvictionPolicy(),
    ExpiryPolicy expiryPolicy = const EternalExpiryPolicy(),
    int maxEntries = 25,
    KeySampler sampler = const FullSampler(),
    EventListenerMode eventListenerMode = EventListenerMode.disabled,
  }) {
    _key = '${module.key}:$id';
    _cache = _getCache(
      evictionPolicy: evictionPolicy,
      expiryPolicy: expiryPolicy,
      maxEntries: maxEntries,
      sampler: sampler,
      eventListenerMode: eventListenerMode,
    );
  }

  /// Returns the the cache with the given ID from the module.
  ///
  /// If the cache has not been instantiated, it will create a new one.
  Cache _getCache({
    EvictionPolicy evictionPolicy = const LruEvictionPolicy(),
    ExpiryPolicy expiryPolicy = const EternalExpiryPolicy(),
    int maxEntries = 25,
    KeySampler sampler = const FullSampler(),
    EventListenerMode eventListenerMode = EventListenerMode.disabled,
  }) {
    return LunaMemoryStore.get(
      id: _key,
      fresh: true,
      evictionPolicy: evictionPolicy,
      expiryPolicy: expiryPolicy,
      maxEntries: maxEntries,
      sampler: sampler,
      eventListenerMode: eventListenerMode,
    );
  }

  Future<bool> contains(String key) async => _cache.containsKey(key);
  Future<dynamic> get(String key) => _cache.get(key);
  Future<int> size() async => _cache.size;
  Future<void> put(String key, dynamic value) => _cache.put(key, value);
  Future<void> remove(String key) async => _cache.remove(key);
  Future<void> clear() async => _cache.clear();
}
