// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

/// Simple dart script to concatenate all module's localization files into a single file for loading into LunaSea.
///
/// This script is designed to be run from the root of the project.
void main() {
  // Check and delete any found prepared localizations
  Directory _assets = Directory('assets/localization');
  if (_assets.existsSync()) _assets.deleteSync(recursive: true);
  // Go through each localization file
  Directory _localization = Directory('localization');
  List<FileSystemEntity> _entities = _localization.listSync();
  _entities.sort((a, b) => a.path.compareTo(b.path));
  _entities.forEach((entity) {
    // Ensure that the filesystem entity is a folder, and finds any files within
    if (FileSystemEntity.isDirectorySync(entity.path)) {
      Directory module = Directory(entity.path);
      print(
        'Processing Module: ${module.path.substring(module.path.lastIndexOf('/') + 1)}',
      );
      List<FileSystemEntity> _languages = module.listSync();
      _languages.sort((a, b) => a.path.compareTo(b.path));
      _languages.forEach((language) {
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
          // If required, create a stub primary language to prevent asset load failures
          if (name.contains('-')) _writeStubPrimaryLanguage(_assets.path, name);
        }
      });
      print('');
    }
  });
}

void _writeStubPrimaryLanguage(String assets, String language) {
  final primary = language.split('-').first;
  final path = '$assets/$primary.json';
  _createFile(path);
}

void _writeFile(String path, Map<dynamic, dynamic>? data) {
  // Read the current data in the file
  File file = File(path);
  Map<dynamic, dynamic>? fileData = jsonDecode(file.readAsStringSync());
  // Ensure the file exists
  if (file.existsSync()) {
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
  if (file.existsSync()) return;
  file.createSync(recursive: true);
  file.writeAsStringSync(
    '{}',
    flush: true,
  );
}
