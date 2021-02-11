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
                    if(showSnackbar) showLunaSuccessSnackBar(context: context, title: movieCopy.monitored ? 'Monitoring' : 'No Longer Monitoring', message: movie.title);
                    return true;
                });
            })
            .catchError((error, stack) {
                LunaLogger().error('Unable to toggle monitored state: ${movie.monitored.toString()} to ${movieCopy.monitored.toString()}', error, stack);
                if(showSnackbar) showLunaErrorSnackBar(context: context, title: movie.monitored ? 'Failed to Unmonitor Movie' : 'Failed to Monitor Movie', error: error);
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
                if(showSnackbar) showLunaSuccessSnackBar(context: context, title: 'Refreshing...', message: movie.title);
                return true;
            })
            .catchError((error, stack) {
                LunaLogger().error('Unable to refresh movie: ${movie.id}', error, stack);
                if(showSnackbar) showLunaErrorSnackBar(context: context, title: 'Failed to Refresh', error: error);
                return false;
            });
        }
        return false;
    }

    /// Add a new movie.
    /// - Calls the add command
    /// - If `showSnackBar` is true, shows an appropriate snackbar/toast
    /// 
    /// Returns the newly added [RadarrMovie] instance.
    Future<RadarrMovie> addMovie({
        @required BuildContext context,
        @required RadarrMovie movie,
        @required RadarrRootFolder rootFolder,
        @required bool monitored,
        @required RadarrQualityProfile qualityProfile,
        @required RadarrAvailability availability,
        @required List<RadarrTag> tags,
        @required bool searchForMovie,
        bool showSnackbar = true,
    }) async {
        assert(movie != null);
        assert(rootFolder != null);
        assert(monitored != null);
        assert(qualityProfile != null);
        assert(availability != null);
        assert(tags != null);
        assert(searchForMovie != null);
        if(context.read<RadarrState>().enabled) {
            return await context.read<RadarrState>().api.movie.create(
                movie: movie,
                rootFolder: rootFolder,
                monitored: monitored,
                qualityProfile: qualityProfile,
                minimumAvailability: availability,
                tags: tags,
                searchForMovie: searchForMovie,
            )
            .then((movie) {
                if(showSnackbar) showLunaSuccessSnackBar(
                    context: context,
                    title: [
                        'Movie Added',
                        if(searchForMovie) '(Searching...)',
                    ].join(' '),
                    message: movie.title,
                );
                return movie;
            })
            .catchError((error, stack) {
                print(error);
                LunaLogger().error('Failed to add movie (tmdbId: ${movie.tmdbId})', error, stack);
                if(showSnackbar) showLunaErrorSnackBar(context: context, title: 'Failed to Add Movie', error: error);
                return null;
            });
        }
        return null;
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
                if(showSnackbar) showLunaSuccessSnackBar(context: context, title: 'Backing Up Database${Constants.TEXT_ELLIPSIS}', message: 'Backing up the database in the background');
                return true;
            })
            .catchError((error, stack) {
                LunaLogger().error('Unable to backup database', error, stack);
                if(showSnackbar) showLunaErrorSnackBar(context: context, title: 'Failed to Backup Database', error: error);
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
                if(showSnackbar) showLunaSuccessSnackBar(context: context, title: 'Searching${Constants.TEXT_ELLIPSIS}', message: 'Searching for all missing movies');
                return true;
            })
            .catchError((error, stack) {
                LunaLogger().error('Unable to search for all missing movies', error, stack);
                if(showSnackbar) showLunaErrorSnackBar(context: context, title: 'Failed to Search', error: error);
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
                if(showSnackbar) showLunaSuccessSnackBar(context: context, title: 'Running RSS Sync${Constants.TEXT_ELLIPSIS}', message: 'Running RSS sync in the background');
                return true;
            })
            .catchError((error, stack) {
                LunaLogger().error('Unable to run RSS sync', error, stack);
                if(showSnackbar) showLunaErrorSnackBar(context: context, title: 'Failed to Run RSS Sync', error: error);
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
                if(showSnackbar) showLunaSuccessSnackBar(context: context, title: 'Updating Library${Constants.TEXT_ELLIPSIS}', message: 'Updating library in the background');
                return true;
            })
            .catchError((error, stack) {
                LunaLogger().error('Unable to update library', error, stack);
                if(showSnackbar) showLunaErrorSnackBar(context: context, title: 'Failed to Update Library', error: error);
                return false;
            });
        }
        return false;
    }

    /// Delete a movie file.
    /// - Calls the command to delete the movie
    /// - If `showSnackbar` is true, shows an appropriate snackbar/toast
    Future<bool> deleteMovieFile({
        @required BuildContext context,
        @required RadarrMovieFile movieFile,
        bool showSnackbar = true,
    }) async {
        assert(movieFile != null);
        if(context.read<RadarrState>().enabled) {
            return await context.read<RadarrState>().api.movieFile.delete(movieFileId: movieFile.id)
            .then((_) {
                if(showSnackbar) showLunaSuccessSnackBar(context: context, title: 'File Deleted', message: movieFile.relativePath);
                return true;
            })
            .catchError((error, stack) {
                LunaLogger().error('Failed to delete movie file: ${movieFile.id}', error, stack);
                if(showSnackbar) showLunaErrorSnackBar(context: context, title: 'Failed to Delete File', error: error);
                return false;
            });
        }
        return false;
    }

    Future<bool> updateMovie({
        @required BuildContext context,
        @required RadarrMovie movie,
        bool showSnackbar = true,
    }) async {
        assert(movie != null);
        if(context.read<RadarrState>().enabled) {
            return await context.read<RadarrState>().api.movie.update(movie: movie)
            .then((_) async {
                return await context.read<RadarrState>().setSingleMovie(movie).then((_) {
                    if(showSnackbar) showLunaSuccessSnackBar(context: context, title: 'Updated Movie', message: movie.title);
                    return true;
                });
            })
            .catchError((error, stack) {
                LunaLogger().error('Failed to update movie: ${movie.id}', error, stack);
                showLunaErrorSnackBar(context: context, title: 'Failed to Update Movie', error: error);
                return false;
            });
        }
        return false;
    }

    Future<bool> removeMovie({
        @required BuildContext context,
        @required RadarrMovie movie,
        bool showSnackbar = true,
    }) async {
        assert(movie != null);
        if(context.read<RadarrState>().enabled) {
            return await context.read<RadarrState>().api.movie.delete(
                movieId: movie.id,
                addImportExclusion: RadarrDatabaseValue.REMOVE_MOVIE_IMPORT_LIST.data,
                deleteFiles: RadarrDatabaseValue.REMOVE_MOVIE_FILES.data,
            ).then((_) async {
                if(showSnackbar) showLunaSuccessSnackBar(
                    context: context,
                    title: [
                        'Removed Movie',
                        if(RadarrDatabaseValue.REMOVE_MOVIE_FILES.data) '(With Files)',
                    ].join(' '),
                    message: movie.title,
                );
                return true;
            })
            .catchError((error, stack) {
                LunaLogger().error('Failed to remove movie: ${movie.id}', error, stack);
                showLunaErrorSnackBar(context: context, title: 'Failed to Remove Movie', error: error);
                return false;
            });
        }
        return false;
    }
}