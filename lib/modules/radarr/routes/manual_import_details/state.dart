import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrManualImportDetailsState extends ChangeNotifier {
    final String path;

    RadarrManualImportDetailsState(BuildContext context, {
        @required this.path,
    }) {
        fetchManualImport(context);
    }

    bool canExecuteAction = false;

    Future<List<RadarrManualImport>> _manualImport;
    Future<List<RadarrManualImport>> get manualImport => _manualImport;
    Future<void> fetchManualImport(BuildContext context) async {
        if(context.read<RadarrState>().enabled) _manualImport = context.read<RadarrState>().api.manualImport.get(
            folder: path,
            filterExistingFiles: true,
        );
        notifyListeners();
    }

    List<int> _selectedFiles = [];
    List<int> get selectedFiles => _selectedFiles;
    set selectedFiles(List<int> selectedFiles) {
        assert(selectedFiles != null);
        _selectedFiles = selectedFiles;
        notifyListeners();
    }

    void addSelectedFile(int id) {
        assert(id != null);
        if(_selectedFiles.contains(id)) return;
        _selectedFiles.add(id);
        notifyListeners();
    }

    void removeSelectedFile(int id) {
        assert(id != null);
        if(!_selectedFiles.contains(id)) return;
        _selectedFiles.remove(id);
        notifyListeners();
    }

    void toggleSelectedFile(int id) {
        _selectedFiles.contains(id) ? removeSelectedFile(id) : addSelectedFile(id);
    }

    void setSelectedFile(int id, bool state) {
        if(!_selectedFiles.contains(id) && state) addSelectedFile(id);
        if(_selectedFiles.contains(id) && !state) removeSelectedFile(id);
    }
}
