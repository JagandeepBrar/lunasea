import 'package:flutter/material.dart';
import 'package:lunasea/modules.dart';
import 'package:lunasea/router/router.dart';
import 'package:lunasea/router/routes/bios.dart';
import 'package:lunasea/router/routes/dashboard.dart';
import 'package:lunasea/router/routes/external_modules.dart';
import 'package:lunasea/router/routes/lidarr.dart';
import 'package:lunasea/router/routes/nzbget.dart';
import 'package:lunasea/router/routes/overseerr.dart';
import 'package:lunasea/router/routes/radarr.dart';
import 'package:lunasea/router/routes/sabnzbd.dart';
import 'package:lunasea/router/routes/search.dart';
import 'package:lunasea/router/routes/settings.dart';
import 'package:lunasea/router/routes/sonarr.dart';
import 'package:lunasea/router/routes/tautulli.dart';
import 'package:lunasea/vendor.dart';
import 'package:lunasea/widgets/pages/not_enabled.dart';

enum LunaRoutes {
  bios('bios', root: BIOSRoutes.HOME),
  dashboard('dashboard', root: DashboardRoutes.HOME),
  externalModules('external_modules', root: ExternalModulesRoutes.HOME),
  lidarr('lidarr', root: LidarrRoutes.HOME),
  nzbget('nzbget', root: NZBGetRoutes.HOME),
  overseerr('overseerr', root: OverseerrRoutes.HOME),
  radarr('radarr', root: RadarrRoutes.HOME),
  sabnzbd('sabnzbd', root: SABnzbdRoutes.HOME),
  search('search', root: SearchRoutes.HOME),
  settings('settings', root: SettingsRoutes.HOME),
  sonarr('sonarr', root: SonarrRoutes.HOME),
  tautulli('tautulli', root: TautulliRoutes.HOME);

  final String key;
  final LunaRoutesMixin root;

  const LunaRoutes(
    this.key, {
    required this.root,
  });

  static String get initialLocation => BIOSRoutes.HOME.path;
}

mixin LunaRoutesMixin on Enum {
  String get _routeName => '${this.module?.key ?? 'unknown'}:$name';

  String get path;
  LunaModule? get module;

  GoRoute get routes;
  List<GoRoute> get subroutes => const <GoRoute>[];

  bool isModuleEnabled(BuildContext context);

  GoRoute route({
    Widget? widget,
    Widget Function(BuildContext, GoRouterState)? builder,
  }) {
    assert(!(widget == null && builder == null));
    return GoRoute(
      path: path,
      name: _routeName,
      routes: subroutes,
      builder: (context, state) {
        if (isModuleEnabled(context)) {
          return builder?.call(context, state) ?? widget!;
        }
        return NotEnabledPage(module: module?.title ?? 'LunaSea');
      },
    );
  }

  GoRoute redirect({
    required GoRouterRedirect redirect,
  }) {
    return GoRoute(
      path: path,
      name: _routeName,
      redirect: redirect,
    );
  }

  void go({
    Object? extra,
    Map<String, String> params = const <String, String>{},
    Map<String, String> queryParams = const <String, String>{},
    bool buildTree = false,
  }) {
    if (buildTree) {
      return LunaRouter.router.goNamed(
        _routeName,
        extra: extra,
        pathParameters: params,
        queryParameters: queryParams,
      );
    }
    LunaRouter.router.pushNamed(
      _routeName,
      extra: extra,
      pathParameters: params,
      queryParameters: queryParams,
    );
  }
}
