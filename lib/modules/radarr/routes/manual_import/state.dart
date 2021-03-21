import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrManualImportState extends ChangeNotifier {
    RadarrManualImportState(BuildContext context) {
        fetchDirectories(context, null);
    }

    TextEditingController currentPathTextController = TextEditingController();

    Future<RadarrFileSystem> _directories;
    Future<RadarrFileSystem> get directories => _directories;
    void fetchDirectories(BuildContext context, String path) {
        if(context.read<RadarrState>().enabled) {
            currentPathTextController.text = path ?? '';
            currentPathTextController.selection = TextSelection.fromPosition(TextPosition(offset: currentPathTextController.text.length));
            _directories = context.read<RadarrState>().api.fileSystem.get(
                path: path,
                includeFiles: false,
                allowFoldersWithoutTrailingSlashes: false,
            );
        }
        notifyListeners();
    }
}
