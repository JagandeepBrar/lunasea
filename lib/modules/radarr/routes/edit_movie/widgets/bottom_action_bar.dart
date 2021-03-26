import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrEditMovieActionBar extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return LunaBottomActionBar(
            actions: [
                LunaButton(
                    type: LunaButtonType.TEXT,
                    text: 'radarr.UpdateMovie'.tr(),
                    icon: Icons.edit_rounded,
                    loadingState: context.watch<RadarrMoviesEditState>().state,
                    onTap: () async => _updateOnTap(context),
                )
            ],
        );
    }

    Future<void> _updateOnTap(BuildContext context) async {
        if(context.read<RadarrMoviesEditState>().canExecuteAction) {
            context.read<RadarrMoviesEditState>().state = LunaLoadingState.ACTIVE;
            await Future.delayed(Duration(seconds: 5), () {});
            if(context.read<RadarrMoviesEditState>().movie != null) {
                RadarrMovie movie = context.read<RadarrMoviesEditState>().movie.updateEdits(context.read<RadarrMoviesEditState>());
                bool result = await RadarrAPIHelper().updateMovie(context: context, movie: movie);
                if(result) Navigator.of(context).lunaSafetyPop();
            }
        }
    }
}
