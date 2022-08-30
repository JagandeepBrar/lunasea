import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class TautulliLogsNewslettersState extends ChangeNotifier {
  TautulliLogsNewslettersState(BuildContext context) {
    fetchLogs(context);
  }

  Future<TautulliNewsletterLogs>? _logs;
  Future<TautulliNewsletterLogs>? get logs => _logs;
  Future<void> fetchLogs(BuildContext context) async {
    if (context.read<TautulliState>().enabled) {
      _logs = context.read<TautulliState>().api!.notifications.getNewsletterLog(
            length: TautulliDatabase.CONTENT_LOAD_LENGTH.read(),
          );
    }
    notifyListeners();
  }
}
