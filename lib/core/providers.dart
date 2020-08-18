//Exports
export 'package:provider/provider.dart';
//Imports
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules.dart' show
    HomeModel,
    LidarrModel,
    NZBGetModel,
    RadarrState,
    SABnzbdModel,
    SearchModel,
    SettingsModel,
    SonarrModel,
    TautulliState;

class Providers {
    Providers._();

    static void reset(BuildContext context) {
        Provider.of<TautulliState>(context, listen: false).reset();
    }
    
    static MultiProvider providers({ @required Widget child }) => MultiProvider(
        providers: [
            // General
            ChangeNotifierProvider(create: (_) => HomeModel()),
            ChangeNotifierProvider(create: (_) => SearchModel()),
            ChangeNotifierProvider(create: (_) => SettingsModel()),
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

