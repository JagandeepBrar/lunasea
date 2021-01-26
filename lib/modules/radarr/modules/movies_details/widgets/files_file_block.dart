import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrMovieDetailsFilesFileBlock extends StatelessWidget {
    final RadarrMovieFile movieFile;

    RadarrMovieDetailsFilesFileBlock({
        Key key,
        @required this.movieFile,
    }): super(key: key);

    @override
    Widget build(BuildContext context) => LSTableBlock(
        children: [
            LSTableContent(title: 'relative path', body: movieFile?.lunaRelativePath),
            LSTableContent(title: 'size', body: movieFile?.lunaSize),
            LSTableContent(title: 'quality', body: movieFile?.lunaQuality),
            LSTableContent(title: 'added', body: movieFile?.lunaDateAdded),
            // TODO: Add additional information, including codec information
            // Decide to show within same block or as a bottom modal sheet
        ],
    );
}
