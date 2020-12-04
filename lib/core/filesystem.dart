import 'dart:io';
import 'package:share/share.dart';
import 'package:path_provider/path_provider.dart';

class LunaFileSystem {
    LunaFileSystem._();

    static Future<String> _getTempFilePath(String filename) async {
        Directory tempDir = await getTemporaryDirectory();
        return '${tempDir.path}/$filename';
    }

    static Future<void> exportFileToTemporaryStorage(String name, String data) async {
        String _file = await _getTempFilePath(name);
        //Write the NZB to the filesystem
        File file = File(_file);
        await file?.writeAsString(data);
        await Share.shareFiles([_file]);
    }
}
