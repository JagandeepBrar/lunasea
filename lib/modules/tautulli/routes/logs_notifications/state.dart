import 'package:flutter/material.dart';
import 'package:lunasea/modules/tautulli.dart';
import 'package:lunasea/core.dart';

class TautulliLogsNotificationsState extends ChangeNotifier {
  TautulliLogsNotificationsState(BuildContext context) {
    fetchLogs(context);
  }

  Future<TautulliNotificationLogs> _logs;
  Future<TautulliNotificationLogs> get logs => _logs;
  Future<void> fetchLogs(BuildContext context) async {
    if (context.read<TautulliState>().enabled) {
      _logs =
          context.read<TautulliState>().api.notifications.getNotificationLog(
                length: TautulliDatabaseValue.CONTENT_LOAD_LENGTH.data,
              );
    }
    notifyListeners();
  }
}
