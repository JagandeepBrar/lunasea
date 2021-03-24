import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrEditMovieUpdateMovieButton extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return LunaButton(
            type: LunaButtonType.TEXT,
            text: 'radarr.UpdateMovie'.tr(),
            loadingState: context.watch<RadarrMoviesEditState>().state,
            onTap: () async {
                context.read<RadarrMoviesEditState>().state = LunaLoadingState.ACTIVE;
                if(context.read<RadarrMoviesEditState>().movie != null) {
                    RadarrMovie movie = context.read<RadarrMoviesEditState>().movie.updateEdits(context.read<RadarrMoviesEditState>());
                    bool result = await RadarrAPIHelper().updateMovie(context: context, movie: movie);
                    if(result) Navigator.of(context).lunaSafetyPop();
                }
            },
        );
    }
}
