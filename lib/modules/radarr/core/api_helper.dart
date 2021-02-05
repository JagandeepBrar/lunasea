import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrAPIHelper {
    /// Toggles the monitored state on a movie.
    /// - Updates the movie
    /// - Updates the movie catalogue list in [RadarrState]
    /// - If `showSnackbar` is true, shows an appropriate snackbar/toast
    Future<bool> toggleMonitored({
        @required BuildContext context,
        @required RadarrMovie movie,
        bool showSnackbar = true,
    }) async {
        assert(movie != null);
        if(context.read<RadarrState>().enabled) {
            RadarrMovie movieDeepCopy = RadarrMovie.fromJson(movie.toJson());
            movieDeepCopy.monitored = !movie.monitored;
            return await context.read<RadarrState>().api.movie.update(movie: movieDeepCopy)
            .then((data) async {
                return await context.read<RadarrState>().setSingleMovie(movieDeepCopy).then((_) {
                    if(showSnackbar) showLunaSuccessSnackBar(
                        context: context,
                        title: movieDeepCopy.monitored ? 'Monitoring' : 'No Longer Monitoring',
                        message: movie.title,
                    );
                    return true;
                });
            })
            .catchError((error, stack) {
                LunaLogger().error('Unable to toggle monitored state: ${movie.monitored.toString()} to ${movieDeepCopy.monitored.toString()}', error, stack);
                if(showSnackbar) showLunaErrorSnackBar(
                    context: context,
                    title: movie.monitored ? 'Failed to Unmonitor Movie' : 'Failed to Monitor Movie',
                    error: error,
                );
                return false;
            });
        }
        return false;
    }
}