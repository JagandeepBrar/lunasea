
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrAddMovieDetailsAddButton extends StatelessWidget {
    final bool searchOnAdd;

    RadarrAddMovieDetailsAddButton({
        Key key,
        @required this.searchOnAdd,
    }) : super(key: key) {
        assert(searchOnAdd != null);
    }

    @override
    Widget build(BuildContext context) => LunaButton(
        text: searchOnAdd ? 'Add + Search' : 'Add',
        backgroundColor: searchOnAdd ? LunaColours.orange : LunaColours.accent,
        onTap: () async => _onTap(context),
        loadingState: context.watch<RadarrAddMovieDetailsState>().state,
    );

    Future<void> _onTap(BuildContext context) async {
        context.read<RadarrAddMovieDetailsState>().state = LunaLoadingState.ACTIVE;
        await RadarrAPIHelper().addMovie(
            context: context,
            movie: context.read<RadarrAddMovieDetailsState>().movie,
            rootFolder: context.read<RadarrAddMovieDetailsState>().rootFolder,
            monitored: context.read<RadarrAddMovieDetailsState>().monitored,
            qualityProfile: context.read<RadarrAddMovieDetailsState>().qualityProfile,
            availability: context.read<RadarrAddMovieDetailsState>().availability,
            tags: context.read<RadarrAddMovieDetailsState>().tags,
            searchForMovie: searchOnAdd,
        )
        .then((movie) async {
            context.read<RadarrState>().fetchMovies();
            context.read<RadarrAddMovieDetailsState>().movie.id = movie.id;
            Navigator.of(context).popAndPushNamed(RadarrMoviesDetailsRouter().route(movieId: movie.id));
        })
        .catchError((error, stack) {
            context.read<RadarrAddMovieDetailsState>().state = LunaLoadingState.ERROR;
        });
        context.read<RadarrAddMovieDetailsState>().state = LunaLoadingState.INACTIVE;
    }
}
