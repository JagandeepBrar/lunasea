// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

/// Simple dart script to concat all module's localization files into a single file for loading into LunaSea.
///
/// This script is designed to be run from the root of the project, using derry: `derry run build_localizations`.
void main() {
  // Check and delete any found prepared localizations
  Directory _assets = Directory('assets/localization');
  if (_assets.existsSync()) _assets.deleteSync(recursive: true);
  // Go through each localization file
  Directory _localization = Directory('localization');
  _localization.listSync().forEach((folder) {
    // Ensure that the filesystem entity is a folder, and finds any files within
    if (FileSystemEntity.isDirectorySync(folder.path)) {
      Directory module = Directory(folder.path);
      print(
        'Processing Module: ${module.path.substring(module.path.lastIndexOf('/') + 1)}',
      );
      module.listSync().forEach((language) {
        print(
          '--> Adding language: ${language.path.substring(language.path.lastIndexOf('/') + 1)}...',
        );
        // Ensures that the filesystem entity is a JSON file
        if (FileSystemEntity.isFileSync(language.path) &&
            language.path.endsWith('.json')) {
          // Create the file (if it does not exist), append language data to it
          String name = Platform.isWindows
              ? language.path.split('\\').last
              : language.path.split('/').last;
          String path = '${_assets.path}/$name';
          _createFile(path);
          File file = File(language.path);
          _writeFile(path, jsonDecode(file.readAsStringSync()));
        }
      });
      print('');
    }
  });
}

void _writeFile(String path, Map<dynamic, dynamic>? data) {
  // Read the current data in the file
  File file = File(path);
  Map<dynamic, dynamic>? fileData = jsonDecode(file.readAsStringSync());
  // Ensure the file exists
  if (file.existsSync()) {
    print('    Appending localization strings...');
    // Add all the localization strings to the file, and write back the string version of the map.
    fileData!.addAll(data!);
    JsonEncoder encoder = const JsonEncoder.withIndent('    ');
    file.writeAsStringSync(
      encoder.convert(fileData),
      mode: FileMode.write,
      flush: true,
    );
  } else {
    print('    Failed to find file. Skipping...');
    return;
  }
}

void _createFile(String path) {
  File file = File(path);
  if (file.existsSync()) {
    print('    Found file. Skipping file creation...');
    return;
  }
  print('    Created empty file...');
  file.createSync(recursive: true);
  file.writeAsStringSync(
    '{}',
    flush: true,
  );
}
