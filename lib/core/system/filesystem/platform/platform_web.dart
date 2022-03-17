import 'package:flutter/material.dart';

import '../filesystem.dart';
import '../file.dart';

class Web implements LunaFileSystem {
  @override
  Future<bool> save(BuildContext context, String name, List<int> data) async {
    throw UnsupportedError('LunaFileSystem unsupported');
  }

  @override
  Future<LunaFile?> read(BuildContext context, List<String> extensions) async {
    throw UnsupportedError('LunaFileSystem unsupported');
  }
}
