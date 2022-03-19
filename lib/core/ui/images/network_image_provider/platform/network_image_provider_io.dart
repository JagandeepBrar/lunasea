import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../cache/image_cache/image_cache.dart';
import '../network_image_provider.dart';

LunaNetworkImageProvider getNetworkImageProvider({
  required String url,
  Map<String, String>? headers,
}) {
  return IO(
    url: url,
    headers: headers,
  );
}

class IO implements LunaNetworkImageProvider {
  String url;
  Map<String, String>? headers;

  IO({
    required this.url,
    this.headers,
  });

  @override
  ImageProvider<Object> get imageProvider {
    return LunaImageCache.isSupported ? _cache() : _default();
  }

  ImageProvider<Object> _cache() {
    return CachedNetworkImageProvider(
      url,
      headers: headers,
      cacheManager: LunaImageCache().instance,
      errorListener: () {},
    );
  }

  ImageProvider<Object> _default() {
    return NetworkImage(
      url,
      headers: headers,
    );
  }
}
