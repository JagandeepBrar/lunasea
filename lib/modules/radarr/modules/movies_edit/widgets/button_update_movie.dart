import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrMoviesEditUpdateMovieButton extends StatelessWidget {
    final RadarrMovie movie;

    RadarrMoviesEditUpdateMovieButton({
        Key key,
        @required this.movie,
    }) : super(key: key);

    @override
    Widget build(BuildContext context) => LSButton(
        text: 'Update Movie',
        onTap: () async => _onTap(context),
        loadingState: context.watch<RadarrMoviesEditState>().state,
    );

    Future<void> _onTap(BuildContext context) async {
        context.read<RadarrMoviesEditState>().state = LunaLoadingState.ACTIVE;
        RadarrMovie _movie = movie.updateEdits(context.read<RadarrMoviesEditState>());
        await context.read<RadarrState>().api.movie.update(movie: _movie)
        .then((_) {
            context.read<RadarrState>().setSingleMovie(_movie);
            showLunaSuccessSnackBar(
                context: context,
                title: 'Updated Movie',
                message: _movie.title,
            );
            LunaRouter.router.pop(context);
        })
        .catchError((error, stack) {
            LunaLogger().error('Failed to update movie: ${movie.id}', error, stack);
            context.read<RadarrMoviesEditState>().state = LunaLoadingState.ERROR;
            showLunaErrorSnackBar(
                context: context,
                title: 'Failed to Update Movie',
                error: error,
            );
        });
    }
}
