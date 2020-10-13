//Exports
export 'package:provider/provider.dart';
//Imports
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules.dart' show
    HomeState,
    SearchState,
    SettingsState,
    LidarrState,
    RadarrState,
    SonarrState,
    NZBGetState,
    SABnzbdState,
    OmbiState,
    TautulliState;

class LunaProvider {
    LunaProvider._();

    static void reset(BuildContext context) {
        // General
        Provider.of<HomeState>(context, listen: false).reset();
        Provider.of<SearchState>(context, listen: false).reset();
        Provider.of<SettingsState>(context, listen: false).reset();
        // Automation
        Provider.of<LidarrState>(context, listen: false).reset();
        Provider.of<RadarrState>(context, listen: false).reset();
        Provider.of<SonarrState>(context, listen: false).reset();
        // Clients
        Provider.of<NZBGetState>(context, listen: false).reset();
        Provider.of<SABnzbdState>(context, listen: false).reset();
        // Monitoring
        Provider.of<OmbiState>(context, listen: false).reset();
        Provider.of<TautulliState>(context, listen: false).reset();
    }
    
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
            ChangeNotifierProvider(create: (_) => OmbiState()),
            ChangeNotifierProvider(create: (_) => TautulliState()),
        ],
        child: child,
    );
}

