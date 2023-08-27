import 'package:flutter/material.dart';
import 'package:lunasea/api/radarr/models/movie/movie.dart';
import 'package:lunasea/modules.dart';
import 'package:lunasea/modules/radarr/core/state.dart';
import 'package:lunasea/modules/radarr/routes/add_movie/route.dart';
import 'package:lunasea/modules/radarr/routes/add_movie_details/route.dart';
import 'package:lunasea/modules/radarr/routes/edit_movie/route.dart';
import 'package:lunasea/modules/radarr/routes/history/route.dart';
import 'package:lunasea/modules/radarr/routes/manual_import/route.dart';
import 'package:lunasea/modules/radarr/routes/manual_import_details/route.dart';
import 'package:lunasea/modules/radarr/routes/movie_details/route.dart';
import 'package:lunasea/modules/radarr/routes/queue/route.dart';
import 'package:lunasea/modules/radarr/routes/radarr/route.dart';
import 'package:lunasea/modules/radarr/routes/releases/route.dart';
import 'package:lunasea/modules/radarr/routes/system_status/route.dart';
import 'package:lunasea/modules/radarr/routes/tags/route.dart';
import 'package:lunasea/router/routes.dart';
import 'package:lunasea/vendor.dart';

enum RadarrRoutes with LunaRoutesMixin {
  HOME('/radarr'),
  ADD_MOVIE('add_movie'),
  ADD_MOVIE_DETAILS('details'),
  HISTORY('history'),
  MANUAL_IMPORT('manual_import'),
  MANUAL_IMPORT_DETAILS('details'),
  MOVIE('movie/:movie'),
  MOVIE_EDIT('edit'),
  MOVIE_RELEASES('releases'),
  QUEUE('queue'),
  SYSTEM_STATUS('system_status'),
  TAGS('tags');

  @override
  final String path;

  const RadarrRoutes(this.path);

  @override
  LunaModule get module => LunaModule.RADARR;

  @override
  bool isModuleEnabled(BuildContext context) {
    return context.read<RadarrState>().enabled;
  }

  @override
  GoRoute get routes {
    switch (this) {
      case RadarrRoutes.HOME:
        return route(widget: const RadarrRoute());
      case RadarrRoutes.ADD_MOVIE:
        return route(builder: (_, state) {
          final query = state.uri.queryParameters['query'] ?? '';
          return AddMovieRoute(query: query);
        });
      case RadarrRoutes.ADD_MOVIE_DETAILS:
        return route(builder: (_, state) {
          final movie = state.extra as RadarrMovie?;
          final isDiscovery =
              state.uri.queryParameters['isDiscovery'] ?? 'false';
          return AddMovieDetailsRoute(
            movie: movie,
            isDiscovery: isDiscovery.toLowerCase() == 'true',
          );
        });
      case RadarrRoutes.HISTORY:
        return route(widget: const HistoryRoute());
      case RadarrRoutes.MANUAL_IMPORT:
        return route(widget: const ManualImportRoute());
      case RadarrRoutes.MANUAL_IMPORT_DETAILS:
        return route(builder: (_, state) {
          final path = state.uri.queryParameters['path'];
          return ManualImportDetailsRoute(path: path);
        });
      case RadarrRoutes.MOVIE:
        return route(builder: (_, state) {
          final movieId =
              int.tryParse(state.pathParameters['movie'] ?? '-1') ?? -1;
          return MovieDetailsRoute(movieId: movieId);
        });
      case RadarrRoutes.MOVIE_EDIT:
        return route(builder: (_, state) {
          final movieId =
              int.tryParse(state.pathParameters['movie'] ?? '-1') ?? -1;
          return MovieEditRoute(movieId: movieId);
        });
      case RadarrRoutes.MOVIE_RELEASES:
        return route(builder: (_, state) {
          final movieId =
              int.tryParse(state.pathParameters['movie'] ?? '-1') ?? -1;
          return MovieReleasesRoute(movieId: movieId);
        });
      case RadarrRoutes.QUEUE:
        return route(widget: const QueueRoute());
      case RadarrRoutes.SYSTEM_STATUS:
        return route(widget: const SystemStatusRoute());
      case RadarrRoutes.TAGS:
        return route(widget: const TagsRoute());
    }
  }

  @override
  List<GoRoute> get subroutes {
    switch (this) {
      case RadarrRoutes.HOME:
        return [
          RadarrRoutes.ADD_MOVIE.routes,
          RadarrRoutes.HISTORY.routes,
          RadarrRoutes.MANUAL_IMPORT.routes,
          RadarrRoutes.MOVIE.routes,
          RadarrRoutes.QUEUE.routes,
          RadarrRoutes.SYSTEM_STATUS.routes,
          RadarrRoutes.TAGS.routes,
        ];
      case RadarrRoutes.ADD_MOVIE:
        return [
          RadarrRoutes.ADD_MOVIE_DETAILS.routes,
        ];
      case RadarrRoutes.MANUAL_IMPORT:
        return [
          RadarrRoutes.MANUAL_IMPORT_DETAILS.routes,
        ];
      case RadarrRoutes.MOVIE:
        return [
          RadarrRoutes.MOVIE_EDIT.routes,
          RadarrRoutes.MOVIE_RELEASES.routes,
        ];
      default:
        return const [];
    }
  }
}
