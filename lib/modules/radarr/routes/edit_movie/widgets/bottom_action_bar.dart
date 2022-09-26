import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';
import 'package:lunasea/router/router.dart';

class RadarrEditMovieActionBar extends StatelessWidget {
  const RadarrEditMovieActionBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LunaBottomActionBar(
      actions: [
        LunaButton(
          type: LunaButtonType.TEXT,
          text: 'lunasea.Update'.tr(),
          icon: Icons.edit_rounded,
          loadingState: context.watch<RadarrMoviesEditState>().state,
          onTap: () async => _updateOnTap(context),
        )
      ],
    );
  }

  Future<void> _updateOnTap(BuildContext context) async {
    final state = context.read<RadarrMoviesEditState>();
    state.state = LunaLoadingState.ACTIVE;

    if (state.canExecuteAction && state.movie != null) {
      bool moveFiles = false;
      if (state.path != state.movie?.path) {
        moveFiles = await RadarrDialogs().moveFiles();
      }

      final movie = state.movie!.updateEdits(state);
      bool result = await RadarrAPIHelper().updateMovie(
        context: context,
        movie: movie,
        moveFiles: moveFiles,
      );
      if (result) LunaRouter().popSafely();
    }
  }
}
