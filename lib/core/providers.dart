//Exports
export 'package:provider/provider.dart';
//Imports
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:provider/provider.dart';
//Models
import 'package:lunasea/modules/home/state.dart';
import 'package:lunasea/modules/lidarr/state.dart';
import 'package:lunasea/modules/nzbget/state.dart';
import 'package:lunasea/modules/radarr/state.dart';
import 'package:lunasea/modules/sabnzbd/state.dart';
import 'package:lunasea/modules/search/state.dart';
import 'package:lunasea/modules/settings/state.dart';
import 'package:lunasea/modules/sonarr/state.dart';

class Providers {
    Providers._();
    
    static MultiProvider providers({ @required Widget child }) => MultiProvider(
        key: ObjectKey(Database.currentProfile),
        providers: [
            ChangeNotifierProvider(create: (context) => HomeModel()),
            ChangeNotifierProvider(create: (context) => LidarrModel()),
            ChangeNotifierProvider(create: (context) => NZBGetModel()),
            ChangeNotifierProvider(create: (context) => RadarrModel()),
            ChangeNotifierProvider(create: (context) => SABnzbdModel()),
            ChangeNotifierProvider(create: (context) => SearchModel()),
            ChangeNotifierProvider(create: (context) => SettingsModel()),
            ChangeNotifierProvider(create: (context) => SonarrModel()),
        ],
        child: child,
    );
}

