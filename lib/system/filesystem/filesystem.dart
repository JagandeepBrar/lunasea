import 'package:flutter/material.dart';
import 'package:lunasea/system/filesystem/file.dart';

// ignore: always_use_package_imports
import 'platform/filesystem_stub.dart'
    if (dart.library.io) 'platform/filesystem_io.dart'
    if (dart.library.html) 'platform/filesystem_html.dart';

abstract class LunaFileSystem {
  static bool get isSupported => isPlatformSupported();
  factory LunaFileSystem() => getFileSystem();

  static bool isValidExtension(List<String> extensions, String? extension) {
    String _ext = extension ?? '';
    return extensions.contains(_ext);
  }

  Future<bool> save(BuildContext context, String name, List<int> data);
  Future<LunaFile?> read(BuildContext context, List<String> extensions);
  Future<void> nuke();
}
