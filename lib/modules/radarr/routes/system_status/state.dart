import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrSystemStatusState extends ChangeNotifier {
  RadarrSystemStatusState(BuildContext context) {
    fetchStatus(context);
    fetchDiskSpace(context);
    fetchHealthCheck(context);
  }

  Future<void> fetchStatus(BuildContext context) async {
    RadarrState state = context.read<RadarrState>();
    if (state.enabled) _status = state.api!.system.status();
    notifyListeners();
    await _status;
  }

  Future<void> fetchDiskSpace(BuildContext context) async {
    RadarrState state = context.read<RadarrState>();
    if (state.enabled) _diskSpace = state.api!.fileSystem.getDiskSpace();
    notifyListeners();
    await _diskSpace;
  }

  Future<void> fetchHealthCheck(BuildContext context) async {
    RadarrState state = context.read<RadarrState>();
    if (state.enabled) _healthCheck = state.api!.healthCheck.get();
    notifyListeners();
    await _healthCheck;
  }

  Future<List<RadarrHealthCheck>>? _healthCheck;
  Future<List<RadarrHealthCheck>>? get healthCheck => _healthCheck;

  Future<RadarrSystemStatus>? _status;
  Future<RadarrSystemStatus>? get status => _status;

  Future<List<RadarrDiskSpace>>? _diskSpace;
  Future<List<RadarrDiskSpace>>? get diskSpace => _diskSpace;
}
