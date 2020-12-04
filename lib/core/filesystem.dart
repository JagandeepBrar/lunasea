import 'dart:io';
import 'package:intl/intl.dart';
import 'package:share/share.dart';
import 'package:path_provider/path_provider.dart';

class LunaFileSystem {
    LunaFileSystem._();

    static String get _configFileName {
        String _now = DateFormat('y-MM-dd kk-mm-ss').format(DateTime.now());
        return '$_now.lunasea';
    }

    static Future<String> _getTempFilePath(String filename) async {
        Directory tempDir = await getTemporaryDirectory();
        return '${tempDir.path}/$filename';
    }

    static Future<void> exportConfigToFilesystem(String config) async {
        String _file = await _getTempFilePath(_configFileName);
        //Write the configuration to the filsystem
        File file = File(_file);
        await file?.writeAsString(config);
        await Share.shareFiles([_file]);
    }

    static Future<void> exportDownloadToFilesystem(String name, String data) async {
        String _file = await _getTempFilePath(name);
        //Write the NZB to the filesystem
        File file = File(_file);
        await file?.writeAsString(data);
        await Share.shareFiles([_file]);
    }
}
