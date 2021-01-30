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
                    onTap: () async => _automatic(context),
                    reducedMargin: true,
                ),
            ),
            Expanded(
                child: LSButton(
                    text: 'Interactive',
                    backgroundColor: LunaColours.orange,
                    onTap: () async => _manual(context),
                    reducedMargin: true,
                ),
            ),
        ],
    );

    Future<void> _automatic(BuildContext context) async {
        Radarr _radarr = context.read<RadarrState>().api;
        if(_radarr != null) _radarr.command.moviesSearch(movieIds: [movie.id])
        .then((_) {
            showLunaSuccessSnackBar(
                context: context,
                title: 'Searching for Movie...',
                message: movie.title,
            );
        })
        .catchError((error, stack) {
            LunaLogger().error('Unable to search for movie: ${movie.id}', error, stack);
            showLunaErrorSnackBar(
                context: context,
                title: 'Failed to Search',
                error: error,
            );
        });
    }

    Future<void> _manual(BuildContext context) async {
        // TODO
    }
}