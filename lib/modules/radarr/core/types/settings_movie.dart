import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';
import 'package:lunasea/router/router.dart';
import 'package:lunasea/router/routes/radarr.dart';

enum RadarrMovieSettingsType {
  EDIT,
  REFRESH,
  DELETE,
  MONITORED,
}

extension RadarrMovieSettingsTypeExtension on RadarrMovieSettingsType {
  IconData icon(RadarrMovie movie) {
    switch (this) {
      case RadarrMovieSettingsType.MONITORED:
        return movie.monitored!
            ? Icons.turned_in_not_rounded
            : Icons.turned_in_rounded;
      case RadarrMovieSettingsType.EDIT:
        return Icons.edit_rounded;
      case RadarrMovieSettingsType.REFRESH:
        return Icons.refresh_rounded;
      case RadarrMovieSettingsType.DELETE:
        return Icons.delete_rounded;
    }
  }

  String name(RadarrMovie movie) {
    switch (this) {
      case RadarrMovieSettingsType.MONITORED:
        return movie.monitored!
            ? 'radarr.UnmonitorMovie'.tr()
            : 'radarr.MonitorMovie'.tr();
      case RadarrMovieSettingsType.EDIT:
        return 'radarr.EditMovie'.tr();
      case RadarrMovieSettingsType.REFRESH:
        return 'radarr.RefreshMovie'.tr();
      case RadarrMovieSettingsType.DELETE:
        return 'radarr.RemoveMovie'.tr();
    }
  }

  Future<void> execute(BuildContext context, RadarrMovie movie) async {
    switch (this) {
      case RadarrMovieSettingsType.EDIT:
        return _edit(context, movie);
      case RadarrMovieSettingsType.REFRESH:
        return _refresh(context, movie);
      case RadarrMovieSettingsType.DELETE:
        return _delete(context, movie);
      case RadarrMovieSettingsType.MONITORED:
        return _monitored(context, movie);
    }
  }

  Future<void> _edit(BuildContext context, RadarrMovie movie) async {
    RadarrRoutes.MOVIE_EDIT.go(params: {
      'movie': movie.id!.toString(),
    });
  }

  Future<void> _monitored(BuildContext context, RadarrMovie movie) =>
      RadarrAPIHelper().toggleMonitored(context: context, movie: movie);
  Future<void> _refresh(BuildContext context, RadarrMovie movie) async =>
      RadarrAPIHelper().refreshMovie(context: context, movie: movie);
  Future<void> _delete(BuildContext context, RadarrMovie movie) async {
    bool result = await RadarrDialogs().removeMovie(context);
    if (result) {
      RadarrAPIHelper().removeMovie(context: context, movie: movie).then((_) {
        context.read<RadarrState>().fetchMovies();
        LunaRouter().popSafely();
      });
    }
  }
}
