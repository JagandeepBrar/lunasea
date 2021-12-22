import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrAddMovieDetailsActionBar extends StatelessWidget {
  const RadarrAddMovieDetailsActionBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LunaBottomActionBar(
      actions: [
        LunaActionBarCard(
          title: 'lunasea.Options'.tr(),
          subtitle: 'radarr.StartSearchFor'.tr(),
          onTap: () async => RadarrDialogs().addMovieOptions(context),
        ),
        LunaButton(
          type: LunaButtonType.TEXT,
          text: 'lunasea.Add'.tr(),
          icon: Icons.add_rounded,
          onTap: () async => _onTap(context, false),
          loadingState: context.watch<RadarrAddMovieDetailsState>().state,
        ),
      ],
    );
  }

  Future<void> _onTap(BuildContext context, bool searchOnAdd) async {
    if (context.read<RadarrAddMovieDetailsState>().canExecuteAction) {
      context.read<RadarrAddMovieDetailsState>().state =
          LunaLoadingState.ACTIVE;
      await RadarrAPIHelper()
          .addMovie(
        context: context,
        movie: context.read<RadarrAddMovieDetailsState>().movie,
        rootFolder: context.read<RadarrAddMovieDetailsState>().rootFolder,
        monitored: context.read<RadarrAddMovieDetailsState>().monitored,
        qualityProfile:
            context.read<RadarrAddMovieDetailsState>().qualityProfile,
        availability: context.read<RadarrAddMovieDetailsState>().availability,
        tags: context.read<RadarrAddMovieDetailsState>().tags,
        searchForMovie: searchOnAdd,
      )
          .then((movie) async {
        context.read<RadarrState>().fetchMovies();
        context.read<RadarrAddMovieDetailsState>().movie.id = movie.id;
        Navigator.of(context).popAndPushNamed(
            RadarrMoviesDetailsRouter().route(movieId: movie.id));
      }).catchError((error, stack) {
        context.read<RadarrAddMovieDetailsState>().state =
            LunaLoadingState.ERROR;
      });
      context.read<RadarrAddMovieDetailsState>().state =
          LunaLoadingState.INACTIVE;
    }
  }
}
