import 'dart:io';
import 'package:file_selector_platform_interface/file_selector_platform_interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lunasea/core.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';

class LunaFileSystem {
    /// Export a given string to the filesystem.
    /// 
    /// Depending on the platform, uses different methods to export the data:
    /// - iOS/Android: System-level sharesheet
    /// - macOS: Save dialog
    Future<bool> exportString(BuildContext context, String name, String data) async {
        if(Platform.isAndroid || Platform.isIOS) {
            return _exportStringToShareSheet(context, name, data);
        } else if(Platform.isMacOS) {
            return _exportStringToFileSystem(name, data);
        } else {
            throw MissingPluginException('No plugin to handle exporting data is available for this platform.');
        }
    }

    /// Export a given string to the OS-level share sheet with the given name.
    /// 
    /// Temporarily writes the string as a [File] to the temporary storage directory on the OS.
    /// 
    /// Temporary storage is eventually cleared by the OS, but is more than enough time to save/send via the share sheet.
    Future<bool> _exportStringToShareSheet(BuildContext context, String name, String data) async {
        try {
            final RenderBox box = context.findRenderObject();
            Directory tempDirectory = await getTemporaryDirectory();
            String path = '${tempDirectory.path}/$name';
            File file = File(path);
            await file?.writeAsString(data);
            await Share.shareFiles(
                [path],
                sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
            );
            return true;
        } catch (error, stack) {
            LunaLogger().error('Failed to share string to sharesheet', error, stack);
        }
        return false;
    }

    /// Export a given string to the OS-level filesystem browser with the given suggested name.
    /// 
    /// Prompts the user with a save dialog prompt with the supplied name as the recommended name.
    Future<bool> _exportStringToFileSystem(String name, String data) async {
        try {
            String path = await FileSelectorPlatform.instance?.getSavePath(suggestedName: name);
            if(path?.isNotEmpty ?? false) {
                File file = File(path);
                await file?.writeAsString(data);
                return true;
            }
        } catch (error, stack) {
            LunaLogger().error('Failed to share string to filesystem', error, stack);
        }
        return false;
    }
}
