import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrMovieDetailsOverviewDownloadButtons extends StatelessWidget {
    final RadarrMovie movie;

    RadarrMovieDetailsOverviewDownloadButtons({
        Key key,
        @required this.movie,
    }) : super(key: key);

    @override
    Widget build(BuildContext context) => LSContainerRow(
        children: [
            Expanded(
                child: LSButton(
                    text: 'Automatic',
                    onTap: _automatic,
                    reducedMargin: true,
                ),
            ),
            Expanded(
                child: LSButton(
                    text: 'Interactive',
                    backgroundColor: LunaColours.orange,
                    onTap: _manual,
                    reducedMargin: true,
                ),
            ),
        ],
    );

    Future<void> _automatic() async {
        // TODO
    }

    Future<void> _manual() async {
        // TODO
    }
}