//Models
export 'package:lunasea/core/providers/models.dart';
export 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core/providers/models.dart';
import 'package:provider/provider.dart';

MultiProvider providers({ @required Widget child }) => MultiProvider(
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
