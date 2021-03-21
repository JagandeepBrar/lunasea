import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrManualImportState extends ChangeNotifier {
    RadarrManualImportState(BuildContext context) {
        _currentPath = '/';
        fetchDirectories(context, _currentPath);
    }

    String _currentPath;
    String get currentPath => _currentPath;
    set currentPath(String currentPath) {
        assert(currentPath != null);
        _currentPath = currentPath;
        notifyListeners();
    }

    Future<RadarrFileSystem> _directories;
    Future<RadarrFileSystem> get directories => _directories;
    void fetchDirectories(BuildContext context, String path) {
        if(context.read<RadarrState>().enabled) {
            _currentPath = path;
            _directories = context.read<RadarrState>().api.fileSystem.get(
                path: path,
                includeFiles: false,
                allowFoldersWithoutTrailingSlashes: false,
            );
        }
        notifyListeners();
    }
}
