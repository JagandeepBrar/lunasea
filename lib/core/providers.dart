//Exports
export 'package:provider/provider.dart';
//Imports
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules.dart' show
    HomeState,
    LidarrModel,
    NZBGetModel,
    RadarrState,
    SABnzbdModel,
    SearchModel,
    SettingsState,
    SonarrModel,
    TautulliState;

class Providers {
    Providers._();

    static void reset(BuildContext context) {
        Provider.of<LunaSeaState>(context, listen: false).reset(initialize: true);
        // General
        Provider.of<HomeState>(context, listen: false).reset(initialize: true);
        Provider.of<SettingsState>(context, listen: false).reset(initialize: true);
        // Monitoring
        Provider.of<TautulliState>(context, listen: false).reset(initialize: true);
    }
    
    static MultiProvider providers({ @required Widget child }) => MultiProvider(
        providers: [
            ChangeNotifierProvider(create: (_) => LunaSeaState()),
            // General
            ChangeNotifierProvider(create: (_) => HomeState()),
            ChangeNotifierProvider(create: (_) => SearchModel()),
            ChangeNotifierProvider(create: (_) => SettingsState()),
            // Automation
            ChangeNotifierProvider(create: (_) => SonarrModel()),
            ChangeNotifierProvider(create: (_) => LidarrModel()),
            ChangeNotifierProvider(create: (_) => RadarrState()),
            // Clients
            ChangeNotifierProvider(create: (_) => NZBGetModel()),
            ChangeNotifierProvider(create: (_) => SABnzbdModel()),
            // Monitoring
            ChangeNotifierProvider(create: (_) => TautulliState()),
        ],
        child: child,
    );
}

