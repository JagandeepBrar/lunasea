import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class TautulliCheckForUpdatesState extends ChangeNotifier {
  TautulliCheckForUpdatesState(BuildContext context) {
    fetchAllUpdates(context);
  }

  Future<void> fetchAllUpdates(BuildContext context) async {
    fetchPlexMediaServer(context);
    fetchTautulli(context);
    await Future.wait([
      if (_plexMediaServer != null) _plexMediaServer!,
      if (_tautulli != null) _tautulli!,
    ]);
  }

  Future<TautulliPMSUpdate>? _plexMediaServer;
  Future<TautulliPMSUpdate>? get plexMediaServer => _plexMediaServer;
  void fetchPlexMediaServer(BuildContext context) {
    if (context.read<TautulliState>().enabled) {
      _plexMediaServer =
          context.read<TautulliState>().api!.system.getPMSUpdate();
    }
    notifyListeners();
  }

  Future<TautulliUpdateCheck>? _tautulli;
  Future<TautulliUpdateCheck>? get tautulli => _tautulli;
  void fetchTautulli(BuildContext context) {
    if (context.read<TautulliState>().enabled) {
      _tautulli = context.read<TautulliState>().api!.system.updateCheck();
    }
    notifyListeners();
  }
}
