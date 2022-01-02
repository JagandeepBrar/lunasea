import 'package:collection/collection.dart' show IterableExtension;
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrAppBarMovieSettingsAction extends StatelessWidget {
  final int movieId;

  const RadarrAppBarMovieSettingsAction({
    Key? key,
    required this.movieId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<RadarrState>(
      builder: (context, state, _) => FutureBuilder(
        future: state.movies,
        builder: (context, AsyncSnapshot<List<RadarrMovie>> snapshot) {
          if (snapshot.hasError) return Container();
          if (snapshot.hasData) {
            RadarrMovie? movie = snapshot.data!.firstWhereOrNull(
              (element) => element.id == movieId,
            );
            if (movie != null)
              return LunaIconButton(
                icon: Icons.more_vert_rounded,
                iconSize: LunaUI.ICON_SIZE,
                onPressed: () async {
                  Tuple2<bool, RadarrMovieSettingsType?> values =
                      await RadarrDialogs().movieSettings(context, movie);
                  if (values.item1) values.item2!.execute(context, movie);
                },
              );
          }
          return Container();
        },
      ),
    );
  }
}
