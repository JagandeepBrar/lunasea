import 'package:flutter/material.dart';
import 'package:lunasea/api/tautulli/types.dart';
import 'package:lunasea/modules.dart';
import 'package:lunasea/modules/tautulli/core/state.dart';
import 'package:lunasea/modules/tautulli/routes/activity_details/route.dart';
import 'package:lunasea/modules/tautulli/routes/check_for_updates/route.dart';
import 'package:lunasea/modules/tautulli/routes/graphs/route.dart';
import 'package:lunasea/modules/tautulli/routes/history_details/route.dart';
import 'package:lunasea/modules/tautulli/routes/ipaddress_details/route.dart';
import 'package:lunasea/modules/tautulli/routes/libraries/route.dart';
import 'package:lunasea/modules/tautulli/routes/libraries_details/route.dart';
import 'package:lunasea/modules/tautulli/routes/logs/route.dart';
import 'package:lunasea/modules/tautulli/routes/logs_logins/route.dart';
import 'package:lunasea/modules/tautulli/routes/logs_newsletters/route.dart';
import 'package:lunasea/modules/tautulli/routes/logs_notifications/route.dart';
import 'package:lunasea/modules/tautulli/routes/logs_plex_media_scanner/route.dart';
import 'package:lunasea/modules/tautulli/routes/logs_plex_media_server/route.dart';
import 'package:lunasea/modules/tautulli/routes/logs_tautulli/route.dart';
import 'package:lunasea/modules/tautulli/routes/media_details/route.dart';
import 'package:lunasea/modules/tautulli/routes/recently_added/route.dart';
import 'package:lunasea/modules/tautulli/routes/search/route.dart';
import 'package:lunasea/modules/tautulli/routes/statistics/route.dart';
import 'package:lunasea/modules/tautulli/routes/synced_items/route.dart';
import 'package:lunasea/modules/tautulli/routes/tautulli/route.dart';
import 'package:lunasea/modules/tautulli/routes/users_details/route.dart';
import 'package:lunasea/router/routes.dart';
import 'package:lunasea/vendor.dart';

enum TautulliRoutes with LunaRoutesMixin {
  HOME('/tautulli'),
  ACTIVITY_DETAILS('activity/:session'),
  CHECK_FOR_UPDATES('check_for_updates'),
  GRAPHS('graphs'),
  HISTORY_DETAILS('history/:rating_key'),
  IP_DETAILS('ip/:ip_address'),
  LIBRARIES('libraries'),
  LIBRARIES_DETAILS(':section'),
  LOGS('logs'),
  LOGS_LOGINS('logins'),
  LOGS_NEWSLETTERS('newsletters'),
  LOGS_NOTIFICATIONS('notifications'),
  LOGS_PLEX_MEDIA_SCANNER('plex_media_scanner'),
  LOGS_PLEX_MEDIA_SERVER('plex_media_server'),
  LOGS_TAUTULLI('tautulli'),
  MEDIA_DETAILS('media/:media_type/:rating_key'),
  RECENTLY_ADDED('recently_added'),
  SEARCH('search'),
  STATISTICS('statistics'),
  SYNCED_ITEMS('synced_items'),
  USER_DETAILS('user/:user');

  @override
  final String path;

  const TautulliRoutes(this.path);

  @override
  LunaModule get module => LunaModule.TAUTULLI;

  @override
  bool isModuleEnabled(BuildContext context) {
    return context.read<TautulliState>().enabled;
  }

  @override
  GoRoute get routes {
    switch (this) {
      case TautulliRoutes.HOME:
        return route(widget: const TautulliRoute());
      case TautulliRoutes.ACTIVITY_DETAILS:
        return route(builder: (_, state) {
          return ActivityDetailsRoute(
            sessionKey:
                int.tryParse(state.pathParameters['session'] ?? '') ?? -1,
          );
        });
      case TautulliRoutes.CHECK_FOR_UPDATES:
        return route(widget: const CheckForUpdatesRoute());
      case TautulliRoutes.GRAPHS:
        return route(widget: const GraphsRoute());
      case TautulliRoutes.HISTORY_DETAILS:
        return route(builder: (_, state) {
          return HistoryDetailsRoute(
            ratingKey:
                int.tryParse(state.pathParameters['rating_key'] ?? '') ?? -1,
            sessionKey:
                int.tryParse(state.uri.queryParameters['session_key'] ?? ''),
            referenceId:
                int.tryParse(state.uri.queryParameters['reference_id'] ?? ''),
          );
        });
      case TautulliRoutes.IP_DETAILS:
        return route(builder: (_, state) {
          return IPDetailsRoute(
            ipAddress: state.pathParameters['ip_address'],
          );
        });
      case TautulliRoutes.LIBRARIES:
        return route(widget: const LibrariesRoute());
      case TautulliRoutes.LIBRARIES_DETAILS:
        return route(builder: (_, state) {
          return LibrariesDetailsRoute(
            sectionId: int.tryParse(state.pathParameters['section'] ?? ''),
          );
        });
      case TautulliRoutes.LOGS:
        return route(widget: const LogsRoute());
      case TautulliRoutes.LOGS_LOGINS:
        return route(widget: const LogsLoginsRoute());
      case TautulliRoutes.LOGS_NEWSLETTERS:
        return route(widget: const LogsNewslettersRoute());
      case TautulliRoutes.LOGS_NOTIFICATIONS:
        return route(widget: const LogsNotificationsRoute());
      case TautulliRoutes.LOGS_PLEX_MEDIA_SCANNER:
        return route(widget: const LogsPlexMediaScannerRoute());
      case TautulliRoutes.LOGS_PLEX_MEDIA_SERVER:
        return route(widget: const LogsPlexMediaServerRoute());
      case TautulliRoutes.LOGS_TAUTULLI:
        return route(widget: const LogsTautulliRoute());
      case TautulliRoutes.MEDIA_DETAILS:
        return route(builder: (_, state) {
          return MediaDetailsRoute(
            ratingKey:
                int.tryParse(state.pathParameters['rating_key'] ?? '') ?? -1,
            mediaType:
                TautulliMediaType.from(state.pathParameters['media_type']),
          );
        });
      case TautulliRoutes.RECENTLY_ADDED:
        return route(widget: const RecentlyAddedRoute());
      case TautulliRoutes.SEARCH:
        return route(widget: const SearchRoute());
      case TautulliRoutes.STATISTICS:
        return route(widget: const StatisticsRoute());
      case TautulliRoutes.SYNCED_ITEMS:
        return route(widget: const SyncedItemsRoute());
      case TautulliRoutes.USER_DETAILS:
        return route(builder: (_, state) {
          return UserDetailsRoute(
            userId: int.tryParse(state.pathParameters['user'] ?? ''),
          );
        });
    }
  }

  @override
  List<GoRoute> get subroutes {
    switch (this) {
      case TautulliRoutes.HOME:
        return [
          TautulliRoutes.ACTIVITY_DETAILS.routes,
          TautulliRoutes.CHECK_FOR_UPDATES.routes,
          TautulliRoutes.GRAPHS.routes,
          TautulliRoutes.HISTORY_DETAILS.routes,
          TautulliRoutes.IP_DETAILS.routes,
          TautulliRoutes.LIBRARIES.routes,
          TautulliRoutes.LOGS.routes,
          TautulliRoutes.MEDIA_DETAILS.routes,
          TautulliRoutes.RECENTLY_ADDED.routes,
          TautulliRoutes.SEARCH.routes,
          TautulliRoutes.STATISTICS.routes,
          TautulliRoutes.SYNCED_ITEMS.routes,
          TautulliRoutes.USER_DETAILS.routes,
        ];
      case TautulliRoutes.LIBRARIES:
        return [
          TautulliRoutes.LIBRARIES_DETAILS.routes,
        ];
      case TautulliRoutes.LOGS:
        return [
          TautulliRoutes.LOGS_LOGINS.routes,
          TautulliRoutes.LOGS_NEWSLETTERS.routes,
          TautulliRoutes.LOGS_NOTIFICATIONS.routes,
          TautulliRoutes.LOGS_PLEX_MEDIA_SCANNER.routes,
          TautulliRoutes.LOGS_PLEX_MEDIA_SERVER.routes,
          TautulliRoutes.LOGS_TAUTULLI.routes,
        ];
      default:
        return const [];
    }
  }
}
