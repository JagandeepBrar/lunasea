import 'package:flutter/material.dart';

// ignore: always_use_package_imports
import 'platform/network_image_provider_stub.dart'
    if (dart.library.io) 'platform/network_image_provider_io.dart'
    if (dart.library.html) 'platform/network_image_provider_html.dart';

abstract class LunaNetworkImageProvider {
  factory LunaNetworkImageProvider({
    required String url,
    Map<String, String>? headers,
  }) {
    return getNetworkImageProvider(
      url: url,
      headers: headers,
    );
  }

  ImageProvider<Object> get imageProvider;
}
