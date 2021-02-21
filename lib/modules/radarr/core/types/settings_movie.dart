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
        switch(this) {
            case RadarrMovieSettingsType.EDIT: return _edit(context, movie);
            case RadarrMovieSettingsType.REFRESH: return _refresh(context, movie);
            case RadarrMovieSettingsType.DELETE: return _delete(context, movie);
            case RadarrMovieSettingsType.MONITORED: return _monitored(context, movie);
        }
        throw Exception('Invalid RadarrMovieSettingsType');
    }

    Future<void> _edit(BuildContext context, RadarrMovie movie) async => RadarrMoviesEditRouter().navigateTo(context, movieId: movie.id);
    Future<void> _monitored(BuildContext context, RadarrMovie movie) => RadarrAPIHelper().toggleMonitored(context: context, movie: movie);
    Future<void> _refresh(BuildContext context, RadarrMovie movie) async => RadarrAPIHelper().refreshMovie(context: context, movie: movie);
    Future<void> _delete(BuildContext context, RadarrMovie movie) async {
        bool result = await RadarrDialogs().removeMovie(context);
        if(result) {
            RadarrAPIHelper().removeMovie(context: context, movie: movie)
            .then((_) {
                context.read<RadarrState>().fetchMovies();
                Navigator.of(context).lunaSafetyPop();
            });
        }
    }
}
