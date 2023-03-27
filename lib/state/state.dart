import 'package:flutter/material.dart';

import 'package:lunasea/modules/dashboard/core/state.dart' as dashboard;
import 'package:lunasea/modules/lidarr/core/state.dart';
import 'package:lunasea/modules/radarr/core/state.dart';
import 'package:lunasea/modules/rss/core/state.dart';
import 'package:lunasea/modules/search/core/state.dart';
import 'package:lunasea/modules/settings/core/state.dart';
import 'package:lunasea/modules/sonarr/core/state.dart';
import 'package:lunasea/modules/overseerr/core/state.dart';
import 'package:lunasea/modules/sabnzbd/core/state.dart';
import 'package:lunasea/modules/nzbget/core/state.dart';
import 'package:lunasea/modules/tautulli/core/state.dart';
import 'package:lunasea/modules.dart';
import 'package:lunasea/router/router.dart';

import 'package:provider/provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' show ProviderScope;

class LunaState {
  LunaState._();

  static BuildContext get context => LunaRouter.navigator.currentContext!;

  /// Calls `.reset()` on all states which extend [LunaModuleState].
  static void reset([BuildContext? context]) {
    final ctx = context ?? LunaState.context;
    LunaModule.values.forEach((module) => module.state(ctx)?.reset());
  }

  static ProviderScope providers({required Widget child}) {
    return ProviderScope(
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => dashboard.ModuleState()),
          ChangeNotifierProvider(create: (_) => SettingsState()),
          ChangeNotifierProvider(create: (_) => SearchState()),
          ChangeNotifierProvider(create: (_) => RssState()),
          ChangeNotifierProvider(create: (_) => LidarrState()),
          ChangeNotifierProvider(create: (_) => RadarrState()),
          ChangeNotifierProvider(create: (_) => SonarrState()),
          ChangeNotifierProvider(create: (_) => NZBGetState()),
          ChangeNotifierProvider(create: (_) => SABnzbdState()),
          ChangeNotifierProvider(create: (_) => OverseerrState()),
          ChangeNotifierProvider(create: (_) => TautulliState()),
        ],
        child: child,
      ),
    );
  }
}

abstract class LunaModuleState extends ChangeNotifier {
  /// Reset the state back to the default
  void reset();
}
