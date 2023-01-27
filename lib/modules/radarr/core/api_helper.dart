import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/extensions/string/string.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrAPIHelper {
  /// Toggles the monitored state on a movie.
  ///
  /// Updates the movie catalogue list in [RadarrState].
  Future<bool> toggleMonitored({
    required BuildContext context,
    required RadarrMovie movie,
    bool showSnackbar = true,
  }) async {
    if (context.read<RadarrState>().enabled) {
      RadarrMovie movieCopy = movie.clone();
      movieCopy.monitored = !movie.monitored!;
      return await context
          .read<RadarrState>()
          .api!
          .movie
          .update(movie: movieCopy)
          .then((data) async {
        return await context
            .read<RadarrState>()
            .setSingleMovie(movieCopy)
            .then((_) {
          if (showSnackbar)
            showLunaSuccessSnackBar(
              title:
                  movieCopy.monitored! ? 'Monitoring' : 'No Longer Monitoring',
              message: movie.title.uiSafe(),
            );
          return true;
        });
      }).catchError((error, stack) {
        LunaLogger().error(
            'Unable to toggle monitored state: ${movie.monitored.toString()} to ${movieCopy.monitored.toString()}',
            error,
            stack);
        if (showSnackbar)
          showLunaErrorSnackBar(
              title: movie.monitored!
                  ? 'Failed to Unmonitor Movie'
                  : 'Failed to Monitor Movie',
              error: error);
        return false;
      });
    }
    return false;
  }

  /// Refreshes a single movie.
  Future<bool> refreshMovie({
    required BuildContext context,
    required RadarrMovie movie,
    bool showSnackbar = true,
  }) async {
    if (context.read<RadarrState>().enabled) {
      return await context
          .read<RadarrState>()
          .api!
          .command
          .refreshMovie(movieIds: [movie.id!]).then((_) {
        if (showSnackbar)
          showLunaSuccessSnackBar(
              title: 'Refreshing...', message: movie.title.uiSafe());
        return true;
      }).catchError((error, stack) {
        LunaLogger()
            .error('Unable to refresh movie: ${movie.id}', error, stack);
        if (showSnackbar)
          showLunaErrorSnackBar(title: 'Failed to Refresh', error: error);
        return false;
      });
    }
    return false;
  }

  /// Add a new movie.
  ///
  /// Returns the newly added [RadarrMovie] instance.
  Future<RadarrMovie?> addMovie({
    required BuildContext context,
    required RadarrMovie movie,
    required RadarrRootFolder rootFolder,
    required bool monitored,
    required RadarrQualityProfile qualityProfile,
    required RadarrAvailability availability,
    required List<RadarrTag> tags,
    required bool searchForMovie,
    bool showSnackbar = true,
  }) async {
    if (context.read<RadarrState>().enabled) {
      final result = await context
          .read<RadarrState>()
          .api!
          .movie
          .create(
            movie: movie,
            rootFolder: rootFolder,
            monitored: monitored,
            qualityProfile: qualityProfile,
            minimumAvailability: availability,
            tags: tags,
            searchForMovie: searchForMovie,
          )
          .then((movie) {
        if (showSnackbar)
          showLunaSuccessSnackBar(
            title: [
              'Movie Added',
              if (searchForMovie) '(Searching...)',
            ].join(' '),
            message: movie.title.uiSafe(),
          );
        return movie;
      }).catchError((error, stack) {
        LunaLogger().error(
            'Failed to add movie (tmdbId: ${movie.tmdbId})', error, stack);
        if (showSnackbar)
          showLunaErrorSnackBar(title: 'Failed to Add Movie', error: error);
        return RadarrMovie();
      });
      if (result.id == null) return null;
      return result;
    }
    return null;
  }

  /// Backup the database.
  Future<bool> backupDatabase({
    required BuildContext context,
    bool showSnackbar = true,
  }) async {
    if (context.read<RadarrState>().enabled) {
      return await context.read<RadarrState>().api!.command.backup().then((_) {
        if (showSnackbar)
          showLunaSuccessSnackBar(
              title: 'Backing Up Database${LunaUI.TEXT_ELLIPSIS}',
              message: 'Backing up the database in the background');
        return true;
      }).catchError((error, stack) {
        LunaLogger().error('Unable to backup database', error, stack);
        if (showSnackbar)
          showLunaErrorSnackBar(
              title: 'Failed to Backup Database', error: error);
        return false;
      });
    }
    return false;
  }

  /// Search for all missing movies.
  Future<bool> missingMovieSearch({
    required BuildContext context,
    bool showSnackbar = true,
  }) async {
    if (context.read<RadarrState>().enabled) {
      return await context
          .read<RadarrState>()
          .api!
          .command
          .missingMovieSearch()
          .then((_) {
        if (showSnackbar)
          showLunaSuccessSnackBar(
              title: 'Searching${LunaUI.TEXT_ELLIPSIS}',
              message: 'Searching for all missing movies');
        return true;
      }).catchError((error, stack) {
        LunaLogger()
            .error('Unable to search for all missing movies', error, stack);
        if (showSnackbar)
          showLunaErrorSnackBar(title: 'Failed to Search', error: error);
        return false;
      });
    }
    return false;
  }

  /// Run an RSS sync.
  Future<bool> runRSSSync({
    required BuildContext context,
    bool showSnackbar = true,
  }) async {
    if (context.read<RadarrState>().enabled) {
      return await context.read<RadarrState>().api!.command.rssSync().then((_) {
        if (showSnackbar)
          showLunaSuccessSnackBar(
              title: 'Running RSS Sync${LunaUI.TEXT_ELLIPSIS}',
              message: 'Running RSS sync in the background');
        return true;
      }).catchError((error, stack) {
        LunaLogger().error('Unable to run RSS sync', error, stack);
        if (showSnackbar)
          showLunaErrorSnackBar(title: 'Failed to Run RSS Sync', error: error);
        return false;
      });
    }
    return false;
  }

  /// Update all movies in your library.
  Future<bool> updateLibrary({
    required BuildContext context,
    bool showSnackbar = true,
  }) async {
    if (context.read<RadarrState>().enabled) {
      return await context
          .read<RadarrState>()
          .api!
          .command
          .refreshMovie()
          .then((_) {
        if (showSnackbar)
          showLunaSuccessSnackBar(
              title: 'Updating Library${LunaUI.TEXT_ELLIPSIS}',
              message: 'Updating library in the background');
        return true;
      }).catchError((error, stack) {
        LunaLogger().error('Unable to update library', error, stack);
        if (showSnackbar)
          showLunaErrorSnackBar(
              title: 'Failed to Update Library', error: error);
        return false;
      });
    }
    return false;
  }

  /// Delete a movie file.
  Future<bool> deleteMovieFile({
    required BuildContext context,
    required RadarrMovieFile movieFile,
    bool showSnackbar = true,
  }) async {
    if (context.read<RadarrState>().enabled) {
      return await context
          .read<RadarrState>()
          .api!
          .movieFile
          .delete(movieFileId: movieFile.id!)
          .then((_) {
        if (showSnackbar)
          showLunaSuccessSnackBar(
            title: 'File Deleted',
            message: movieFile.relativePath.uiSafe(),
          );
        return true;
      }).catchError((error, stack) {
        LunaLogger().error(
            'Failed to delete movie file: ${movieFile.id}', error, stack);
        if (showSnackbar)
          showLunaErrorSnackBar(title: 'Failed to Delete File', error: error);
        return false;
      });
    }
    return false;
  }

  /// Update a movie in Radarr.
  Future<bool> updateMovie({
    required BuildContext context,
    required RadarrMovie movie,
    required bool moveFiles,
    bool showSnackbar = true,
  }) async {
    if (context.read<RadarrState>().enabled) {
      return await context
          .read<RadarrState>()
          .api!
          .movie
          .update(movie: movie, moveFiles: moveFiles)
          .then((_) async {
        return await context
            .read<RadarrState>()
            .setSingleMovie(movie)
            .then((_) {
          if (showSnackbar)
            showLunaSuccessSnackBar(
              title: 'Updated Movie',
              message: movie.title.uiSafe(),
            );
          return true;
        });
      }).catchError((error, stack) {
        LunaLogger().error('Failed to update movie: ${movie.id}', error, stack);
        showLunaErrorSnackBar(title: 'Failed to Update Movie', error: error);
        return false;
      });
    }
    return false;
  }

  /// Remove a movie.
  Future<bool> removeMovie({
    required BuildContext context,
    required RadarrMovie movie,
    bool showSnackbar = true,
  }) async {
    if (context.read<RadarrState>().enabled) {
      return await context
          .read<RadarrState>()
          .api!
          .movie
          .delete(
            movieId: movie.id!,
            addImportExclusion: RadarrDatabase.REMOVE_MOVIE_IMPORT_LIST.read(),
            deleteFiles: RadarrDatabase.REMOVE_MOVIE_DELETE_FILES.read(),
          )
          .then((_) async {
        movie.id = null;
        return await context
            .read<RadarrState>()
            .setSingleMovie(movie)
            .then((_) {
          if (showSnackbar)
            showLunaSuccessSnackBar(
              title: [
                'Removed Movie',
                if (RadarrDatabase.REMOVE_MOVIE_DELETE_FILES.read())
                  '(With Files)',
              ].join(' '),
              message: movie.title.uiSafe(),
            );
          return true;
        });
      }).catchError((error, stack) {
        LunaLogger().error('Failed to remove movie: ${movie.id}', error, stack);
        showLunaErrorSnackBar(title: 'Failed to Remove Movie', error: error);
        return false;
      });
    }
    return false;
  }

  /// Execute a quick import.
  Future<bool> quickImport({
    required BuildContext context,
    required String path,
    bool showSnackbar = true,
  }) async {
    if (context.read<RadarrState>().enabled) {
      return await context
          .read<RadarrState>()
          .api!
          .command
          .downloadedMoviesScan(path: path)
          .then((_) async {
        if (showSnackbar)
          showLunaSuccessSnackBar(
            title: 'Running Quick Import${LunaUI.TEXT_ELLIPSIS}',
            message: path,
          );
        return true;
      }).catchError((error, stack) {
        LunaLogger().error(
            'Failed to execute downloaded movies scan: $path', error, stack);
        showLunaErrorSnackBar(title: 'Failed to Quick Import', error: error);
        return false;
      });
    }
    return false;
  }

  /// Trigger an automatic search of a movie.
  Future<bool> automaticSearch({
    required BuildContext context,
    required int movieId,
    required String title,
    bool showSnackbar = true,
  }) async {
    if (context.read<RadarrState>().enabled) {
      return await context
          .read<RadarrState>()
          .api!
          .command
          .moviesSearch(movieIds: [movieId]).then((_) async {
        if (showSnackbar)
          showLunaSuccessSnackBar(
            title: 'Searching for Movie...',
            message: title,
          );
        return true;
      }).catchError((error, stack) {
        LunaLogger()
            .error('Failed to search for movie: $movieId', error, stack);
        if (showSnackbar)
          showLunaErrorSnackBar(title: 'Failed to Search', error: error);
        return false;
      });
    }
    return false;
  }

  /// Push a release to the download client(s) connected to Radarr.
  Future<bool> pushRelease({
    required BuildContext context,
    required RadarrRelease release,
    bool showSnackbar = true,
  }) async {
    if (context.read<RadarrState>().enabled) {
      return await context
          .read<RadarrState>()
          .api!
          .release
          .push(indexerId: release.indexerId!, guid: release.guid!)
          .then((value) {
        if (showSnackbar)
          showLunaSuccessSnackBar(
            title: 'Downloading Release...',
            message: release.title.uiSafe(),
          );
        return true;
      }).catchError((error, stack) {
        LunaLogger()
            .error('Failed to download release: ${release.guid}', error, stack);
        if (showSnackbar)
          showLunaErrorSnackBar(
              title: 'Failed to Download Release', error: error);
        return false;
      });
    }
    return false;
  }

  /// Add a new tag.
  Future<bool> addTag({
    required BuildContext context,
    required String label,
    bool showSnackbar = true,
  }) async {
    if (context.read<RadarrState>().enabled) {
      return await context
          .read<RadarrState>()
          .api!
          .tag
          .create(label: label)
          .then((tag) {
        showLunaSuccessSnackBar(
          title: 'radarr.AddedTag'.tr(),
          message: tag.label.uiSafe(),
        );
        return true;
      }).catchError((error, stack) {
        LunaLogger().error('Failed to add tag: $label', error, stack);
        if (showSnackbar)
          showLunaErrorSnackBar(
            title: 'radarr.FailedToAddTag'.tr(),
            error: error,
          );
        return false;
      });
    }
    return false;
  }

  /// Delete a tag.
  Future<bool> deleteTag({
    required BuildContext context,
    required RadarrTag tag,
    bool showSnackbar = true,
  }) async {
    if (context.read<RadarrState>().enabled) {
      return await context
          .read<RadarrState>()
          .api!
          .tag
          .delete(id: tag.id!)
          .then((_) {
        showLunaSuccessSnackBar(
          title: 'Deleted Tag',
          message: tag.label.uiSafe(),
        );
        return true;
      }).catchError((error, stack) {
        LunaLogger().error('Failed to add tag: ${tag.id}', error, stack);
        if (showSnackbar)
          showLunaErrorSnackBar(title: 'Failed to Delete Tag', error: error);
        return false;
      });
    }
    return false;
  }

  Future<bool> triggerManualImport({
    required BuildContext context,
    required List<RadarrManualImportFile> files,
    required RadarrImportMode importMode,
    bool showSnackbar = true,
  }) async {
    if (context.read<RadarrState>().enabled) {
      return await context
          .read<RadarrState>()
          .api!
          .command
          .manualImport(
            files: files,
            importMode: importMode,
          )
          .then((_) {
        String message = '${files.length} Files';
        if (files.length == 1) message = files[0].path!;
        showLunaSuccessSnackBar(
          title: 'Importing... (${importMode.value.toTitleCase()})',
          message: message,
        );
        return true;
      }).catchError((error, stack) {
        LunaLogger().error('Failed to trigger manual import', error, stack);
        if (showSnackbar)
          showLunaErrorSnackBar(title: 'Failed to Import', error: error);
        return false;
      });
    }
    return false;
  }

  /// Given a [RadarrManualImport] instance, create a [RadarrManualImportFile] which is sent within the command to start the import.
  Tuple2<RadarrManualImportFile?, String?> buildManualImportFile({
    required RadarrManualImport import,
  }) {
    if (import.movie == null || import.movie!.id == null)
      return const Tuple2(null, 'All selections must have a movie set');
    if (import.quality == null || (import.quality?.quality?.id ?? -1) < 0)
      return const Tuple2(null, 'All selections must have a quality set');
    if ((import.languages?.length ?? 0) == 0)
      return const Tuple2(null, 'All selections must have a language set');
    return Tuple2(
      RadarrManualImportFile(
        path: import.path,
        movieId: import.movie!.id,
        quality: import.quality,
        languages: import.languages,
      ),
      null,
    );
  }
}
