import 'package:flutter/material.dart';

import 'package:lunasea/modules/dashboard/core/state.dart' as dashboard;
import 'package:lunasea/modules/lidarr/core/state.dart';
import 'package:lunasea/modules/radarr/core/state.dart';
import 'package:lunasea/modules/search/core/state.dart';
import 'package:lunasea/modules/settings/core/state.dart';
import 'package:lunasea/modules/sonarr/core/state.dart';
import 'package:lunasea/modules/overseerr/core/state.dart';
import 'package:lunasea/modules/sabnzbd/core/state.dart';
import 'package:lunasea/modules/nzbget/core/state.dart';
import 'package:lunasea/modules/tautulli/core/state.dart';
import 'package:lunasea/core/modules.dart';

import 'package:provider/provider.dart';

class LunaState {
  LunaState._();

  /// Key for the [NavigatorState] to globally access context and other usages.
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  /// Calls `.reset()` on all states which extend [LunaModuleState].
  static void reset(BuildContext context) {
    LunaModule.values.forEach((module) => module.state(context)?.reset());
  }

  /// Returns a [MultiProvider] with the provided child.
  ///
  /// The [MultiProvider] has a [ChangeNotifierProvider] provider added for each module global state object.
  static MultiProvider providers({required Widget child}) => MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => dashboard.ModuleState()),
          ChangeNotifierProvider(create: (_) => SettingsState()),
          ChangeNotifierProvider(create: (_) => SearchState()),
          ChangeNotifierProvider(create: (_) => LidarrState()),
          ChangeNotifierProvider(create: (_) => RadarrState()),
          ChangeNotifierProvider(create: (_) => SonarrState()),
          ChangeNotifierProvider(create: (_) => NZBGetState()),
          ChangeNotifierProvider(create: (_) => SABnzbdState()),
          ChangeNotifierProvider(create: (_) => OverseerrState()),
          ChangeNotifierProvider(create: (_) => TautulliState()),
        ],
        child: child,
      );
}
