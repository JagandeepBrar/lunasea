import 'package:flutter/material.dart';

import 'file.dart';
import './platform/filesystem_stub.dart'
    if (dart.library.io) './platform/filesystem_io.dart'
    if (dart.library.html) './platform/filesystem_web.dart';

abstract class LunaFileSystem {
  static bool get isSupported => isPlatformSupported();
  factory LunaFileSystem() => getFileSystem();

  Future<bool> save(BuildContext context, String name, List<int> data);
  Future<LunaFile?> read(BuildContext context, List<String> extensions);

  static bool isValidExtension(List<String> extensions, String? extension) {
    String _ext = extension ?? '';
    return extensions.contains(_ext);
  }
}
