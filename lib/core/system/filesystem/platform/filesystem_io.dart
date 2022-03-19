import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../../ui.dart';
import '../../../utilities/logger.dart';
import '../../platform.dart';
import '../file.dart';
import '../filesystem.dart';

bool isPlatformSupported() {
  final platform = LunaPlatform();
  return platform.isMobile || platform.isDesktop;
}

LunaFileSystem getFileSystem() {
  switch (defaultTargetPlatform) {
    // Mobile
    case TargetPlatform.android:
    case TargetPlatform.iOS:
      return _Mobile();
    // Desktop
    case TargetPlatform.linux:
    case TargetPlatform.macOS:
    case TargetPlatform.windows:
      return _Desktop();
    default:
      throw UnsupportedError('LunaFileSystem unsupported');
  }
}

class _Desktop implements LunaFileSystem {
  @override
  Future<bool> save(BuildContext context, String name, List<int> data) async {
    try {
      String? path = await FilePicker.platform.saveFile(
        fileName: name,
        lockParentWindow: true,
      );
      if (path != null) {
        File file = File(path);
        file.writeAsBytesSync(data);
        return true;
      }
      return false;
    } catch (error, stack) {
      LunaLogger().error('Failed to save to filesystem', error, stack);
      rethrow;
    }
  }

  @override
  Future<LunaFile?> read(BuildContext context, List<String> extensions) async {
    try {
      final result = await FilePicker.platform.pickFiles(withData: true);

      if (result?.files.isNotEmpty ?? false) {
        String? _ext = result!.files[0].extension;
        if (LunaFileSystem.isValidExtension(extensions, _ext)) {
          return LunaFile(
            path: result.files[0].path!,
            data: result.files[0].bytes!,
          );
        } else {
          showLunaErrorSnackBar(
            title: 'lunasea.InvalidFileTypeSelected'.tr(),
            message: extensions.map((s) => '.$s').join(', '),
          );
        }
      }

      return null;
    } catch (error, stack) {
      LunaLogger().error('Failed to read from filesystem', error, stack);
      rethrow;
    }
  }
}

class _Mobile implements LunaFileSystem {
  @override
  Future<bool> save(BuildContext context, String name, List<int> data) async {
    try {
      Directory directory = await getTemporaryDirectory();
      String path = '${directory.path}/$name';
      File file = File(path);
      file.writeAsBytesSync(data);

      // Determine share window position
      RenderBox? box = context.findRenderObject() as RenderBox?;
      Rect? rect;
      if (box != null) rect = box.localToGlobal(Offset.zero) & box.size;

      ShareResult result = await Share.shareFilesWithResult(
        [path],
        sharePositionOrigin: rect,
      );
      switch (result.status) {
        case ShareResultStatus.success:
          return true;
        case ShareResultStatus.unavailable:
        case ShareResultStatus.dismissed:
          return false;
      }
    } catch (error, stack) {
      LunaLogger().error('Failed to save to filesystem', error, stack);
      rethrow;
    }
  }

  @override
  Future<LunaFile?> read(BuildContext context, List<String> extensions) async {
    try {
      final result = await FilePicker.platform.pickFiles(withData: true);

      if (result?.files.isNotEmpty ?? false) {
        String? _ext = result!.files[0].extension;
        if (LunaFileSystem.isValidExtension(extensions, _ext)) {
          return LunaFile(
            path: result.files[0].path!,
            data: result.files[0].bytes!,
          );
        } else {
          showLunaErrorSnackBar(
            title: 'lunasea.InvalidFileTypeSelected'.tr(),
            message: extensions.map((s) => '.$s').join(', '),
          );
        }
      }

      return null;
    } catch (error, stack) {
      LunaLogger().error('Failed to read from filesystem', error, stack);
      rethrow;
    }
  }
}
