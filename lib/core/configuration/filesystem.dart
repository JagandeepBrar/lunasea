import 'dart:io';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

class Filesystem {
    Filesystem._();

    static String get configFileName {
        String _now = DateFormat('y-MM-dd kk-mm-ss').format(DateTime.now());
        return '$_now.json';
    }

    static Future<String> get appDirectory async {
        Directory appDocDir = await getApplicationDocumentsDirectory();
        return '${appDocDir.path}';
    }

    static Future<String> get configDirectory async {
        String _appDirectory = await appDirectory;
        return '$_appDirectory/configurations';
    }

    static Future<String> get downloadDirectory async {
        String _appDirectory = await appDirectory;
        return '$_appDirectory/downloads';
    }

    static Future<String> get configFullPath async {
        String path = await configDirectory;
        String name = configFileName;
        return '$path/$name';
    }

    static Future<String> downloadFullPath(String name) async {
        String path = await downloadDirectory;
        return '$path/$name';
    }

    static Future<void> exportConfigToFilesystem(String config) async {
        String _file = await configFullPath;
        String _directory = await configDirectory;
        //Create configuration folder if needed
        Directory directory = Directory(_directory);
        if(!await directory.exists()) await directory.create();
        //Write the configuration to the filsystem
        File file = File(_file);
        file?.writeAsString(config);
    }

    static Future<void> exportDownloadToFilesystem(String name, String data) async {
        String _nzb = await downloadFullPath(name);
        String _directory = await downloadDirectory;
        //Create download folder if needed
        Directory directory = Directory(_directory);
        if(!await directory.exists()) await directory.create();
        //Write the NZB to the filesystem
        File file = File(_nzb);
        file?.writeAsString(data);
    }
}
