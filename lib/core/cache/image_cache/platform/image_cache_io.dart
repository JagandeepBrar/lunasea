import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import '../../../../system/platform.dart';
import '../image_cache.dart';

bool isPlatformSupported() {
  final platform = LunaPlatform();
  return platform.isMobile || platform.isMacOS;
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
