import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class TautulliLogsNotificationsState extends ChangeNotifier {
  TautulliLogsNotificationsState(BuildContext context) {
    fetchLogs(context);
  }

  Future<TautulliNotificationLogs>? _logs;
  Future<TautulliNotificationLogs>? get logs => _logs;
  Future<void> fetchLogs(BuildContext context) async {
    if (context.read<TautulliState>().enabled) {
      _logs =
          context.read<TautulliState>().api!.notifications.getNotificationLog(
                length: TautulliDatabase.CONTENT_LOAD_LENGTH.read(),
              );
    }
    notifyListeners();
  }
}
