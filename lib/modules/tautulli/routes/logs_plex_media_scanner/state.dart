import 'package:flutter/material.dart';
import 'package:lunasea/modules/tautulli.dart';
import 'package:lunasea/core.dart';

class TautulliLogsPlexMediaScannerState extends ChangeNotifier {
  TautulliLogsPlexMediaScannerState(BuildContext context) {
    fetchLogs(context);
  }

  Future<List<TautulliPlexLog>> _logs;
  Future<List<TautulliPlexLog>> get logs => _logs;
  Future<void> fetchLogs(BuildContext context) async {
    if (context.read<TautulliState>().enabled) {
      _logs = context.read<TautulliState>().api.miscellaneous.getPlexLog(
            window: TautulliDatabaseValue.CONTENT_LOAD_LENGTH.data,
            logType: TautulliPlexLogType.SCANNER,
          );
    }
    notifyListeners();
  }
}
