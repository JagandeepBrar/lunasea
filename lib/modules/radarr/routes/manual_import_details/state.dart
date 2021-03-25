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

    Future<List<RadarrManualImport>> _manualImport;
    Future<List<RadarrManualImport>> get manualImport => _manualImport;
    Future<void> fetchManualImport(BuildContext context) async {
        if(context.read<RadarrState>().enabled) _manualImport = context.read<RadarrState>().api.manualImport.get(
            folder: path,
            filterExistingFiles: true,
        );
        notifyListeners();
    }
}
