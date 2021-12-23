import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class LunaImageCache {
  static const _key = 'LUNA_IMAGE_CACHE';
  static CacheManager instance = CacheManager(Config(_key));

  /// Initialize the image cache by setting [ImageCache]'s maximumSize and maximumSizeBytes.
  void initialize() {
    ImageCache().maximumSize = 1000;
    ImageCache().maximumSizeBytes = 128 << 20;
  }

  /// Clear the cached images
  Future<void> clear() => instance.emptyCache();
}
