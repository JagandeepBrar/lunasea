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
    RadarrGlobalState,
    SABnzbdModel,
    SearchModel,
    SettingsModel,
    SonarrModel;

class Providers {
    Providers._();
    
    static MultiProvider providers({ @required Widget child }) => MultiProvider(
        key: ObjectKey(Database.currentProfile),
        providers: [
            ChangeNotifierProvider(create: (context) => HomeModel()),
            ChangeNotifierProvider(create: (context) => LidarrModel()),
            ChangeNotifierProvider(create: (context) => NZBGetModel()),
            ChangeNotifierProvider(create: (context) => RadarrGlobalState()),
            ChangeNotifierProvider(create: (context) => SABnzbdModel()),
            ChangeNotifierProvider(create: (context) => SearchModel()),
            ChangeNotifierProvider(create: (context) => SettingsModel()),
            ChangeNotifierProvider(create: (context) => SonarrModel()),
        ],
        child: child,
    );
}

