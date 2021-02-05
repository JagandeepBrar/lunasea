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
            RadarrMovie movieCopy = movie.clone();
            movieCopy.monitored = !movie.monitored;
            return await context.read<RadarrState>().api.movie.update(movie: movieCopy)
            .then((data) async {
                return await context.read<RadarrState>().setSingleMovie(movieCopy).then((_) {
                    if(showSnackbar) showLunaSuccessSnackBar(
                        context: context,
                        title: movieCopy.monitored ? 'Monitoring' : 'No Longer Monitoring',
                        message: movie.title,
                    );
                    return true;
                });
            })
            .catchError((error, stack) {
                LunaLogger().error('Unable to toggle monitored state: ${movie.monitored.toString()} to ${movieCopy.monitored.toString()}', error, stack);
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

    /// Refreshes a single movie.
    /// - Calls the refresh command
    /// - If `showSnackbar` is true, shows an appropriate snackbar/toast
    Future<bool> refreshMovie({
        @required BuildContext context,
        @required RadarrMovie movie,
        bool showSnackbar = true,
    }) async {
        assert(movie != null);
        if(context.read<RadarrState>().enabled) {
            return await context.read<RadarrState>().api.command.refreshMovie(movieIds: [movie.id])
            .then((_) {
                showLunaSuccessSnackBar(
                    context: context,
                    title: 'Refreshing...',
                    message: movie.title,
                );
                return true;
            })
            .catchError((error, stack) {
                LunaLogger().error('Unable to refresh movie: ${movie.id}', error, stack);
                showLunaErrorSnackBar(
                    context: context,
                    title: 'Failed to Refresh',
                    error: error,
                );
                return false;
            });
        }
        return false;
    }

    /// Backup the database.
    /// - Calls the backup command
    /// - If `showSnackbar` is true, shows an appropriate snackbar/toast
    Future<bool> backupDatabase({
        @required BuildContext context,
        bool showSnackbar = true,
    }) async {
        if(context.read<RadarrState>().enabled) {
            return await context.read<RadarrState>().api.command.backup()
            .then((_) {
                showLunaSuccessSnackBar(
                    context: context,
                    title: 'Backing Up Database${Constants.TEXT_ELLIPSIS}',
                    message: 'Backing up the database in the background',
                );
                return true;
            })
            .catchError((error, stack) {
                LunaLogger().error('Unable to backup database', error, stack);
                showLunaErrorSnackBar(
                    context: context,
                    title: 'Failed to Backup Database',
                    error: error,
                );
                return false;
            });
        }
        return false;
    }

    /// Search for all missing movies.
    /// - Calls the missingMovieSearch command
    /// - If `showSnackbar` is true, shows an appropriate snackbar/toast
    Future<bool> missingMovieSearch({
        @required BuildContext context,
        bool showSnackbar = true,
    }) async {
        if(context.read<RadarrState>().enabled) {
            return await context.read<RadarrState>().api.command.missingMovieSearch()
            .then((_) {
                showLunaSuccessSnackBar(
                    context: context,
                    title: 'Searching${Constants.TEXT_ELLIPSIS}',
                    message: 'Searching for all missing movies',
                );
                return true;
            })
            .catchError((error, stack) {
                LunaLogger().error('Unable to search for all missing movies', error, stack);
                showLunaErrorSnackBar(
                    context: context,
                    title: 'Failed to Search',
                    error: error,
                );
                return false;
            });
        }
        return false;
    }

    /// Run an RSS sync.
    /// - Calls the runRssSync command
    /// - If `showSnackbar` is true, shows an appropriate snackbar/toast
    Future<bool> runRSSSync({
        @required BuildContext context,
        bool showSnackbar = true,
    }) async {
        if(context.read<RadarrState>().enabled) {
            return await context.read<RadarrState>().api.command.rssSync()
            .then((_) {
                showLunaSuccessSnackBar(
                    context: context,
                    title: 'Running RSS Sync${Constants.TEXT_ELLIPSIS}',
                    message: 'Running RSS sync in the background',
                );
                return true;
            })
            .catchError((error, stack) {
                LunaLogger().error('Unable to run RSS sync', error, stack);
                showLunaErrorSnackBar(
                    context: context,
                    title: 'Failed to Run RSS Sync',
                    error: error,
                );
                return false;
            });
        }
        return false;
    }

    /// Update all movies in your library.
    /// - Calls the refreshMovie command (for all movies)
    /// - If `showSnackbar` is true, shows an appropriate snackbar/toast
    Future<bool> updateLibrary({
        @required BuildContext context,
        bool showSnackbar = true,
    }) async {
        if(context.read<RadarrState>().enabled) {
            return await context.read<RadarrState>().api.command.refreshMovie()
            .then((_) {
                showLunaSuccessSnackBar(
                    context: context,
                    title: 'Updating Library${Constants.TEXT_ELLIPSIS}',
                    message: 'Updating library in the background',
                );
                return true;
            })
            .catchError((error, stack) {
                LunaLogger().error('Unable to update library', error, stack);
                showLunaErrorSnackBar(
                    context: context,
                    title: 'Failed to Update Library',
                    error: error,
                );
                return false;
            });
        }
        return false;
    }
}