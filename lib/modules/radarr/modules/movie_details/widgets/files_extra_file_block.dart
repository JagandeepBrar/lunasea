import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrMovieDetailsFilesExtraFileBlock extends StatelessWidget {
    final RadarrExtraFile extraFile;

    RadarrMovieDetailsFilesExtraFileBlock({
        Key key,
        @required this.extraFile,
    }): super(key: key);

    @override
    Widget build(BuildContext context) => LunaTableCard(
        content: [
            LunaTableContent(title: 'relative path', body: extraFile?.lunaRelativePath),
            LunaTableContent(title: 'type', body: extraFile?.lunaType),
            LunaTableContent(title: 'extension', body: extraFile?.lunaExtension),
        ],
    );
}
