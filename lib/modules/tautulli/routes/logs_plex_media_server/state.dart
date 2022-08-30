import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class TautulliLogsPlexMediaServerState extends ChangeNotifier {
  TautulliLogsPlexMediaServerState(BuildContext context) {
    fetchLogs(context);
  }

  Future<List<TautulliPlexLog>>? _logs;
  Future<List<TautulliPlexLog>>? get logs => _logs;
  Future<void> fetchLogs(BuildContext context) async {
    if (context.read<TautulliState>().enabled) {
      _logs = context.read<TautulliState>().api!.miscellaneous.getPlexLog(
            window: TautulliDatabase.CONTENT_LOAD_LENGTH.read(),
            logType: TautulliPlexLogType.SERVER,
          );
    }
    notifyListeners();
  }
}
