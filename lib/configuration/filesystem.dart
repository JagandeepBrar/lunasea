import 'dart:io';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:lunasea/system/constants.dart';

class Filesystem {
    Filesystem._();

    static String get currentDateTime {
        return DateFormat('y-MM-dd kk-mm-ss').format(DateTime.now()) ?? Constants.FILESYSTEM_INVALID;
    }

    static String get fileName {
        return currentDateTime == Constants.FILESYSTEM_INVALID ? Constants.FILESYSTEM_INVALID : '$currentDateTime.json';
    }

    static Future<String> get appDirectory async {
        Directory appDocDir = await getApplicationDocumentsDirectory();
        return appDocDir?.path ?? Constants.FILESYSTEM_INVALID;
    }

    static Future<String> get fullDocumentPath async {
        String path = await appDirectory;
        String name = fileName;
        if(path != Constants.FILESYSTEM_INVALID && name != Constants.FILESYSTEM_INVALID) {
            return '$path/$name';
        }
        return Constants.FILESYSTEM_INVALID;
    }

    static Future<bool> exportConfigToFilesystem(String config) async {
        String path = await fullDocumentPath;
        if(path != Constants.FILESYSTEM_INVALID) {
            File file = File(path);
            file?.writeAsString(config);
            return true;
        }
        return false;
    }
}
