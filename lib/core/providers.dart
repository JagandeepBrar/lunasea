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
    OmbiState,
    RadarrState,
    SABnzbdModel,
    SearchModel,
    SettingsState,
    SonarrState,
    TautulliState;

class LunaProvider {
    LunaProvider._();
    
    static MultiProvider providers({
        @required Key key,
        @required Widget child,
    }) => MultiProvider(
        key: key,
        providers: [
            // General
            ChangeNotifierProvider(create: (_) => HomeState()),
            ChangeNotifierProvider(create: (_) => SearchModel()),
            ChangeNotifierProvider(create: (_) => SettingsState()),
            // Automation
            ChangeNotifierProvider(create: (_) => SonarrState()),
            ChangeNotifierProvider(create: (_) => LidarrModel()),
            ChangeNotifierProvider(create: (_) => RadarrState()),
            // Clients
            ChangeNotifierProvider(create: (_) => NZBGetModel()),
            ChangeNotifierProvider(create: (_) => SABnzbdModel()),
            // Monitoring
            ChangeNotifierProvider(create: (_) => OmbiState()),
            ChangeNotifierProvider(create: (_) => TautulliState()),
        ],
        child: child,
    );
}

