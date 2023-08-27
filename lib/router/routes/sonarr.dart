import 'package:flutter/material.dart';
import 'package:lunasea/api/sonarr/models.dart';
import 'package:lunasea/modules.dart';
import 'package:lunasea/modules/sonarr/core/state.dart';
import 'package:lunasea/modules/sonarr/routes/add_series/route.dart';
import 'package:lunasea/modules/sonarr/routes/add_series_details/route.dart';
import 'package:lunasea/modules/sonarr/routes/edit_series/route.dart';
import 'package:lunasea/modules/sonarr/routes/history/route.dart';
import 'package:lunasea/modules/sonarr/routes/queue/route.dart';
import 'package:lunasea/modules/sonarr/routes/releases/route.dart';
import 'package:lunasea/modules/sonarr/routes/season_details/route.dart';
import 'package:lunasea/modules/sonarr/routes/series_details/route.dart';
import 'package:lunasea/modules/sonarr/routes/sonarr/route.dart';
import 'package:lunasea/modules/sonarr/routes/tags/route.dart';
import 'package:lunasea/router/routes.dart';
import 'package:lunasea/vendor.dart';

enum SonarrRoutes with LunaRoutesMixin {
  HOME('/sonarr'),
  ADD_SERIES('add_series'),
  ADD_SERIES_DETAILS('details'),
  HISTORY('history'),
  QUEUE('queue'),
  RELEASES('releases'),
  SERIES('series/:series'),
  SERIES_EDIT('edit'),
  SERIES_SEASON('season/:season'),
  TAGS('tags');

  @override
  final String path;

  const SonarrRoutes(this.path);

  @override
  LunaModule get module => LunaModule.SONARR;

  @override
  bool isModuleEnabled(BuildContext context) {
    return context.read<SonarrState>().enabled;
  }

  @override
  GoRoute get routes {
    switch (this) {
      case SonarrRoutes.HOME:
        return route(widget: const SonarrRoute());
      case SonarrRoutes.ADD_SERIES:
        return route(builder: (_, state) {
          final query = state.uri.queryParameters['query'] ?? '';
          return AddSeriesRoute(query: query);
        });
      case SonarrRoutes.ADD_SERIES_DETAILS:
        return route(builder: (_, state) {
          final series = state.extra as SonarrSeries?;
          return AddSeriesDetailsRoute(series: series);
        });
      case SonarrRoutes.HISTORY:
        return route(widget: const HistoryRoute());
      case SonarrRoutes.QUEUE:
        return route(widget: const QueueRoute());
      case SonarrRoutes.RELEASES:
        return route(builder: (_, state) {
          final episode =
              int.tryParse(state.uri.queryParameters['episode'] ?? '');
          final series =
              int.tryParse(state.uri.queryParameters['series'] ?? '');
          final season =
              int.tryParse(state.uri.queryParameters['season'] ?? '');
          return ReleasesRoute(
            episodeId: episode,
            seriesId: series,
            seasonNumber: season,
          );
        });
      case SonarrRoutes.SERIES:
        return route(builder: (_, state) {
          final seriesId =
              int.tryParse(state.pathParameters['series'] ?? '-1') ?? -1;
          return SeriesDetailsRoute(seriesId: seriesId);
        });
      case SonarrRoutes.SERIES_EDIT:
        return route(builder: (_, state) {
          final seriesId =
              int.tryParse(state.pathParameters['series'] ?? '-1') ?? -1;
          return SeriesEditRoute(seriesId: seriesId);
        });
      case SonarrRoutes.SERIES_SEASON:
        return route(builder: (_, state) {
          final seriesId =
              int.tryParse(state.pathParameters['series'] ?? '-1') ?? -1;
          final season =
              int.tryParse(state.pathParameters['season'] ?? '-1') ?? -1;
          return SeriesSeasonDetailsRoute(
            seriesId: seriesId,
            seasonNumber: season,
          );
        });
      case SonarrRoutes.TAGS:
        return route(widget: const TagsRoute());
    }
  }

  @override
  List<GoRoute> get subroutes {
    switch (this) {
      case SonarrRoutes.HOME:
        return [
          SonarrRoutes.ADD_SERIES.routes,
          SonarrRoutes.HISTORY.routes,
          SonarrRoutes.QUEUE.routes,
          SonarrRoutes.RELEASES.routes,
          SonarrRoutes.SERIES.routes,
          SonarrRoutes.TAGS.routes,
        ];
      case SonarrRoutes.ADD_SERIES:
        return [
          SonarrRoutes.ADD_SERIES_DETAILS.routes,
        ];
      case SonarrRoutes.SERIES:
        return [
          SonarrRoutes.SERIES_EDIT.routes,
          SonarrRoutes.SERIES_SEASON.routes,
        ];
      default:
        return const [];
    }
  }
}
