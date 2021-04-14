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
        context.read<DashboardState>()?.reset();
        context.read<SettingsState>()?.reset();
        if(LunaModule.SEARCH.enabled) context.read<SearchState>()?.reset();
        if(LunaModule.LIDARR.enabled) context.read<LidarrState>()?.reset();
        if(LunaModule.RADARR.enabled) context.read<RadarrState>()?.reset();
        if(LunaModule.SONARR.enabled) context.read<SonarrState>()?.reset();
        if(LunaModule.NZBGET.enabled) context.read<NZBGetState>()?.reset();
        if(LunaModule.SABNZBD.enabled) context.read<SABnzbdState>()?.reset();
        if(LunaModule.OVERSEERR.enabled) context.read<OverseerrState>()?.reset();
        if(LunaModule.TAUTULLI.enabled) context.read<TautulliState>()?.reset();
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
