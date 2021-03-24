import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrManualImportDetailsImportTile extends StatelessWidget {
    final RadarrManualImport manualImport;

    RadarrManualImportDetailsImportTile({
        Key key,
        @required this.manualImport,
    }) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return LunaListTile(
            context: context,
            title: LunaText.title(text: manualImport.relativePath),
        );
    }
}
