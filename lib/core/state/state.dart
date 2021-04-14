import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules.dart';

class LunaState {
    LunaState._();

    /// Key for the [NavigatorState] to globally access context and other usages.
    static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
    
    /// Calls `.reset()` on all states which extend [LunaModuleState].
    static void reset(BuildContext context) {
        LunaModule.values.forEach((module) {
            if(module.enabled) module.state(context)?.reset();
        });
    }
    
    /// Returns a [MultiProvider] with the provided child.
    /// 
    /// The [MultiProvider] has a [ChangeNotifierProvider] provider added for each module global state object.
    static MultiProvider providers({ @required Widget child }) => MultiProvider(
        providers: [
            ChangeNotifierProvider(create: (_) => DashboardState()),
            ChangeNotifierProvider(create: (_) => SettingsState()),
            if(LunaModule.SEARCH.enabled) ChangeNotifierProvider(create: (_) => SearchState()),
            if(LunaModule.LIDARR.enabled) ChangeNotifierProvider(create: (_) => LidarrState()),
            if(LunaModule.RADARR.enabled) ChangeNotifierProvider(create: (_) => RadarrState()),
            if(LunaModule.SONARR.enabled) ChangeNotifierProvider(create: (_) => SonarrState()),
            if(LunaModule.NZBGET.enabled) ChangeNotifierProvider(create: (_) => NZBGetState()),
            if(LunaModule.SABNZBD.enabled) ChangeNotifierProvider(create: (_) => SABnzbdState()),
            if(LunaModule.OVERSEERR.enabled) ChangeNotifierProvider(create: (_) => OverseerrState()),
            if(LunaModule.TAUTULLI.enabled) ChangeNotifierProvider(create: (_) => TautulliState()),
        ],
        child: child,
    );
}
