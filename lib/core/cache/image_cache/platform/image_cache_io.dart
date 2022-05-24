import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:lunasea/system/platform.dart';

// ignore: always_use_package_imports
import '../image_cache.dart';

bool isPlatformSupported() {
  return LunaPlatform.isMobile || LunaPlatform.isMacOS;
}

LunaImageCache getImageCache() {
  if (isPlatformSupported()) return IO();
  throw UnsupportedError('LunaImageCache unsupported');
}

class IO implements LunaImageCache {
  static final CacheManager _cache = CacheManager(Config(LunaImageCache.key));

  @override
  CacheManager get instance => _cache;

  @override
  Future<void> clear() async => _cache.emptyCache();

  @override
  void initialize() {
    ImageCache().maximumSize = 1000;
    ImageCache().maximumSizeBytes = 128 << 20;
  }
}
