import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules.dart';

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
          ChangeNotifierProvider(create: (_) => DashboardState()),
          ChangeNotifierProvider(create: (_) => SettingsState()),
          ChangeNotifierProvider(create: (_) => SearchState()),
          ChangeNotifierProvider(create: (_) => LidarrState()),
          ChangeNotifierProvider(create: (_) => RadarrState()),
          ChangeNotifierProvider(create: (_) => ReadarrState()),
          ChangeNotifierProvider(create: (_) => SonarrState()),
          ChangeNotifierProvider(create: (_) => NZBGetState()),
          ChangeNotifierProvider(create: (_) => SABnzbdState()),
          ChangeNotifierProvider(create: (_) => OverseerrState()),
          ChangeNotifierProvider(create: (_) => TautulliState()),
        ],
        child: child,
      );
}
