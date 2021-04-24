import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:file_selector_platform_interface/file_selector_platform_interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lunasea/core.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';

class LunaFileSystem {
  /// Export a given byte array to the filesystem.
  ///
  /// Depending on the platform, uses different methods to export the data:
  /// - iOS/Android: Utilizes system-level sharesheet
  /// - macOS: Uses standard OS save dialog
  Future<bool> export(BuildContext context, String name, List<int> data) async {
    if (Platform.isAndroid || Platform.isIOS) {
      return _exportMobile(context, name, data);
    } else if (Platform.isMacOS) {
      return _exportDesktop(name, data);
    } else {
      throw MissingPluginException(
          'No plugin to handle exporting data is available for this platform.');
    }
  }

  /// Import a file from the filesystem.
  ///
  /// Depending on the platform, uses different methods to import the data:
  /// - iOS/Android: Utilizes `file_picker` to use mobile-OS file picker
  /// - macOS: Uses standard OS file picker
  Future<File> import(
      BuildContext context, List<String> acceptedExtensions) async {
    if (Platform.isAndroid || Platform.isIOS) {
      return _importMobile(context, acceptedExtensions);
    } else if (Platform.isMacOS) {
      return _importDesktop(acceptedExtensions);
    } else {
      throw MissingPluginException(
          'No plugin to handle importing data is available for this platform.');
    }
  }

  /// Import a file from the filesystem (mobile).
  ///
  /// Allows selection of any filetype, but will check the extension of the selected file against [acceptedExtensions].
  /// If not found in the array, or if any error occurs, will return null.
  Future<File> _importMobile(
      BuildContext context, List<String> acceptedExtensions) async {
    try {
      FilePickerResult _file = await FilePicker.platform.pickFiles(
        type: FileType.any,
        allowMultiple: false,
        allowCompression: false,
        withData: false,
      );
      if (_file != null &&
          acceptedExtensions.contains(_file.files[0].extension ?? '')) {
        return File(_file.files[0].path);
      }
    } catch (error, stack) {
      LunaLogger().error('Failed to import data from filesystem', error, stack);
    }
    return null;
  }

  /// Export a given byte array to the OS-level share sheet with the given name.
  ///
  /// Temporarily writes the byte array as a [File] to the temporary storage directory on the OS.
  ///
  /// Temporary storage is eventually cleared by the OS, but is more than enough time to save/send via the share sheet.
  Future<bool> _exportMobile(
      BuildContext context, String name, List<int> data) async {
    try {
      final RenderBox box = context.findRenderObject();
      Directory tempDirectory = await getTemporaryDirectory();
      String path = '${tempDirectory.path}/$name';
      File file = File(path);
      await file?.writeAsBytes(data);
      await Share.shareFiles(
        [path],
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
      );
      return true;
    } catch (error, stack) {
      LunaLogger().error('Failed to export data to sharesheet', error, stack);
    }
    return false;
  }

  /// Export the given data to the OS-level filesystem save dialog with the given suggested name.
  ///
  /// Prompts the user with a save dialog prompt with the supplied name as the recommended name.
  Future<bool> _exportDesktop(String name, List<int> data) async {
    try {
      String path =
          await FileSelectorPlatform.instance?.getSavePath(suggestedName: name);
      if (path?.isNotEmpty ?? false) {
        File file = File(path);
        await file?.writeAsBytes(data);
        return true;
      }
    } catch (error, stack) {
      LunaLogger().error('Failed to export data to filesystem', error, stack);
    }
    return false;
  }

  /// Import a file from the filesystem (Desktop).
  ///
  /// Locks selection to the given [acceptedExtensions].
  /// If any error occurs, will return null.
  Future<File> _importDesktop(List<String> acceptedExtensions) async {
    try {
      final typeGroup = XTypeGroup(
        label: 'types',
        extensions: acceptedExtensions,
      );
      XFile file = await FileSelectorPlatform.instance
          ?.openFile(acceptedTypeGroups: [typeGroup]);
      return File(file.path);
    } catch (error, stack) {
      LunaLogger().error('Failed to import data from filesystem', error, stack);
    }
    return null;
  }
}
