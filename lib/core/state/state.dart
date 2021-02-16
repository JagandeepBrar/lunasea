import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lunasea/modules/home/core.dart' show HomeState;
import 'package:lunasea/modules/search/core.dart' show SearchState;
import 'package:lunasea/modules/settings/core.dart' show SettingsState;
import 'package:lunasea/modules/lidarr/core.dart' show LidarrState;
import 'package:lunasea/modules/radarr/core.dart' show RadarrState;
import 'package:lunasea/modules/sonarr/core.dart' show SonarrState;
import 'package:lunasea/modules/nzbget/core.dart' show NZBGetState;
import 'package:lunasea/modules/sabnzbd/core.dart' show SABnzbdState;
import 'package:lunasea/modules/tautulli/core.dart' show TautulliState;
export 'package:provider/provider.dart';

class LunaState {
    LunaState._();

    static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

    /// Calls `.reset()` on all states which extend [LunaModuleState].
    static void reset(BuildContext context) {
        // General
        Provider.of<HomeState>(context, listen: false)?.reset();
        Provider.of<SearchState>(context, listen: false)?.reset();
        Provider.of<SettingsState>(context, listen: false)?.reset();
        // Automation
        Provider.of<LidarrState>(context, listen: false)?.reset();
        Provider.of<RadarrState>(context, listen: false)?.reset();
        Provider.of<SonarrState>(context, listen: false)?.reset();
        // Clients
        Provider.of<NZBGetState>(context, listen: false)?.reset();
        Provider.of<SABnzbdState>(context, listen: false)?.reset();
        // Monitoring
        Provider.of<TautulliState>(context, listen: false)?.reset();
    }
    
    /// Returns a [MultiProvider] with the provided child.
    /// 
    /// The [MultiProvider] has a [ChangeNotifierProvider] provider added for each module global state object.
    static MultiProvider providers({ @required Widget child }) => MultiProvider(
        providers: [
            // General
            ChangeNotifierProvider(create: (_) => HomeState()),
            ChangeNotifierProvider(create: (_) => SearchState()),
            ChangeNotifierProvider(create: (_) => SettingsState()),
            // Automation
            ChangeNotifierProvider(create: (_) => SonarrState()),
            ChangeNotifierProvider(create: (_) => LidarrState()),
            ChangeNotifierProvider(create: (_) => RadarrState()),
            // Clients
            ChangeNotifierProvider(create: (_) => NZBGetState()),
            ChangeNotifierProvider(create: (_) => SABnzbdState()),
            // Monitoring
            ChangeNotifierProvider(create: (_) => TautulliState()),
        ],
        child: child,
    );
}

