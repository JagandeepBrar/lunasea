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
    Widget build(BuildContext context) {
        return LunaButtonContainer(
            children: [
                LunaButton(
                    text: 'Update Movie',
                    loadingState: context.watch<RadarrMoviesEditState>().state,
                    onTap: () async {
                        context.read<RadarrMoviesEditState>().state = LunaLoadingState.ACTIVE;
                        RadarrMovie updatedMovie = movie.updateEdits(context.read<RadarrMoviesEditState>());
                        bool result = await RadarrAPIHelper().updateMovie(context: context, movie: updatedMovie);
                        if(result) Navigator.of(context).lunaSafetyPop();
                    },
                ),
            ],
        );
    }
}
