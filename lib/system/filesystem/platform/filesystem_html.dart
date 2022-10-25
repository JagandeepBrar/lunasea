// ignore: avoid_web_libraries_in_flutter
import 'dart:html';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/system/filesystem/file.dart';
import 'package:lunasea/system/filesystem/filesystem.dart';
import 'package:lunasea/system/logger.dart';
import 'package:lunasea/vendor.dart';
import 'package:lunasea/widgets/ui.dart';

bool isPlatformSupported() => true;
LunaFileSystem getFileSystem() {
  if (isPlatformSupported()) return _Web();
  throw UnsupportedError('LunaFileSystem unsupported');
}

class _Web implements LunaFileSystem {
  @override
  Future<void> nuke() async {}

  @override
  Future<bool> save(BuildContext context, String name, List<int> data) async {
    try {
      final blob = Blob([utf8.decode(data)]);
      final anchor = AnchorElement(href: Url.createObjectUrlFromBlob(blob));
      anchor.setAttribute('download', name);
      anchor.click();
      return true;
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
            name: result.files[0].name,
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
