import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

enum RadarrMovieSettingsType {
    EDIT,
    REFRESH,
    DELETE,
    MONITORED,
}

extension RadarrMovieSettingsTypeExtension on RadarrMovieSettingsType {
    IconData icon(RadarrMovie movie) {
        switch(this) {
            case RadarrMovieSettingsType.MONITORED: return movie.monitored ? Icons.turned_in_not : Icons.turned_in;
            case RadarrMovieSettingsType.EDIT: return Icons.edit;
            case RadarrMovieSettingsType.REFRESH: return Icons.refresh;
            case RadarrMovieSettingsType.DELETE: return Icons.delete;
        }
        throw Exception('Invalid RadarrMovieSettingsType');
    }

    String name(RadarrMovie movie) {
        switch(this) {
            case RadarrMovieSettingsType.MONITORED: return movie.monitored ? 'Unmonitor Movie' : 'Monitor Movie';
            case RadarrMovieSettingsType.EDIT: return 'Edit Movie';
            case RadarrMovieSettingsType.REFRESH: return 'Refresh Movie';
            case RadarrMovieSettingsType.DELETE: return 'Remove Movie';
        }
        throw Exception('Invalid RadarrMovieSettingsType');
    }

    Future<void> execute(BuildContext context, RadarrMovie movie) async {
        // TODO
        switch(this) {
            case RadarrMovieSettingsType.EDIT: return;
            case RadarrMovieSettingsType.REFRESH: return _refresh(context, movie);
            case RadarrMovieSettingsType.DELETE: return;
            case RadarrMovieSettingsType.MONITORED: return;
        }
        throw Exception('Invalid RadarrMovieSettingsType');
    }

    static Future<void> _refresh(BuildContext context, RadarrMovie movie) async {
        Radarr _radarr = Provider.of<RadarrState>(context, listen: false).api;
        if(_radarr != null) _radarr.command.refreshMovie(movieIds: [movie.id])
        .then((_) {
            showLunaSuccessSnackBar(
                context: context,
                title: 'Refreshing...',
                message: movie.title,
            );
        })
        .catchError((error, stack) {
            LunaLogger().error('Unable to refresh movie: ${movie.id}', error, stack);
            showLunaErrorSnackBar(
                context: context,
                title: 'Failed to Refresh',
                error: error,
            );
        });
    }
}
