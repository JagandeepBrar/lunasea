import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class LunaNetworkImageProvider {
  final String url;
  final CancellationToken cancelToken;

  final Map<String, String>? headers;

  LunaNetworkImageProvider({
    required this.url,
    required this.cancelToken,
    this.headers,
  });

  ImageProvider<Object> get imageProvider {
    return ExtendedNetworkImageProvider(
      url,
      headers: headers,
      printError: false,
      cache: true,
      cancelToken: cancelToken,
    );
  }
}
