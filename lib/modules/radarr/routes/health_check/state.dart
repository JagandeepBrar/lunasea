import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrHealthCheckState extends ChangeNotifier {
    RadarrHealthCheckState(BuildContext context) {
        fetchHealthCheck(context);
    }

    Future<List<RadarrHealthCheck>> _healthCheck;
    Future<List<RadarrHealthCheck>> get healthCheck => _healthCheck;

    Future<void> fetchHealthCheck(BuildContext context) async {
        RadarrState state = context.read<RadarrState>();
        if(state.enabled) _healthCheck = state.api.healthCheck.get();
        notifyListeners();
        await _healthCheck;
    }
}
