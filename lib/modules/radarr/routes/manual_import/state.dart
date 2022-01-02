import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrManualImportState extends ChangeNotifier {
  RadarrManualImportState(BuildContext context) {
    fetchDirectories(context, null);
  }

  String _currentPath = '';
  String get currentPath => _currentPath;
  set currentPath(String path) {
    _currentPath = path;
    updateTextControllerText();
    notifyListeners();
  }

  TextEditingController currentPathTextController = TextEditingController();
  void updateTextControllerText() {
    currentPathTextController.text = _currentPath;
    currentPathTextController.selection =
        TextSelection.fromPosition(TextPosition(offset: _currentPath.length));
  }

  Future<RadarrFileSystem>? _directories;
  Future<RadarrFileSystem>? get directories => _directories;
  void fetchDirectories(BuildContext context, String? path) {
    if (context.read<RadarrState>().enabled) {
      _directories = context
          .read<RadarrState>()
          .api!
          .fileSystem
          .get(
            path: path,
            includeFiles: false,
            allowFoldersWithoutTrailingSlashes: false,
          )
          .whenComplete(() => currentPath = path ?? '');
    }
    notifyListeners();
  }
}
