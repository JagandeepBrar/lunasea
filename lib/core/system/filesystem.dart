import 'dart:io';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';

class LunaFileSystem {
    /// Export a given string to the OS-level share sheet with the given name.
    /// 
    /// Temporarily writes the string as a [File] to the temporary storage directory on the OS.
    /// 
    /// Temporary storage is eventually cleared by the OS, but is more than enough time to save/send via the share sheet.
    Future<void> exportStringToShareSheet(BuildContext context, String name, String data) async {
        final RenderBox box = context.findRenderObject();
        Directory tempDirectory = await getTemporaryDirectory();
        String path = '${tempDirectory.path}/$name';
        File file = File(path);
        await file?.writeAsString(data);
        await Share.shareFiles(
            [path],
            sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
        ).catchError((error, stack) {
            LunaLogger().error('Failed to share string to sharesheet', error, stack);
        });
    }

    /// Given a path to a file, shares the file to the OS-level share sheet with the given name.
    /// 
    /// The path can be anywhere on the OS, but must be accessible by the application or will throw an error.
    /// If the file does not exist, will simply do nothing.
    Future<void> exportFileToShareSheet(BuildContext context, String path) async {
        final RenderBox box = context.findRenderObject();
        File file = File(path);
        if(file.existsSync()) await Share.shareFiles(
            [path],
            sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
        ).catchError((error, stack) {
            LunaLogger().error('Failed to share file to sharesheet', error, stack);
        });
    }
}
