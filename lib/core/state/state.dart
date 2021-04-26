import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules.dart';

class LunaState {
  LunaState._();

  /// Key for the [NavigatorState] to globally access context and other usages.
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  /// Calls `.reset()` on all states which extend [LunaModuleState].
  static void reset(BuildContext context) {
    LunaModule.values.forEach((module) {
      if (module.isGloballyEnabled) module.state(context)?.reset();
    });
  }

  /// Returns a [MultiProvider] with the provided child.
  ///
  /// The [MultiProvider] has a [ChangeNotifierProvider] provider added for each module global state object.
  static MultiProvider providers({@required Widget child}) => MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => DashboardState()),
          ChangeNotifierProvider(create: (_) => SettingsState()),
          if (LunaModule.SEARCH.isGloballyEnabled)
            ChangeNotifierProvider(create: (_) => SearchState()),
          if (LunaModule.LIDARR.isGloballyEnabled)
            ChangeNotifierProvider(create: (_) => LidarrState()),
          if (LunaModule.RADARR.isGloballyEnabled)
            ChangeNotifierProvider(create: (_) => RadarrState()),
          if (LunaModule.SONARR.isGloballyEnabled)
            ChangeNotifierProvider(create: (_) => SonarrState()),
          if (LunaModule.NZBGET.isGloballyEnabled)
            ChangeNotifierProvider(create: (_) => NZBGetState()),
          if (LunaModule.SABNZBD.isGloballyEnabled)
            ChangeNotifierProvider(create: (_) => SABnzbdState()),
          if (LunaModule.OVERSEERR.isGloballyEnabled)
            ChangeNotifierProvider(create: (_) => OverseerrState()),
          if (LunaModule.TAUTULLI.isGloballyEnabled)
            ChangeNotifierProvider(create: (_) => TautulliState()),
        ],
        child: child,
      );
}
