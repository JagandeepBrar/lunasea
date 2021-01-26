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
    Widget build(BuildContext context) => LSTableBlock(
        children: [
            LSTableContent(title: 'relative path', body: extraFile?.lunaRelativePath),
            LSTableContent(title: 'type', body: extraFile?.lunaType),
            LSTableContent(title: 'extension', body: extraFile?.lunaExtension),
            LSContainerRow(
                children: [
                    Expanded(
                        child: LSButtonSlim(text: 'Delete',
                            onTap: () async => _deleteFile(context),
                            backgroundColor: LunaColours.red,
                        ),
                    ),
                ],
            ),
        ],
    );

    Future<void> _deleteFile(BuildContext context) async {
        // TODO
    }
}
