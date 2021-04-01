import 'package:flutter/material.dart';
import 'package:lunasea/modules/tautulli.dart';
import 'package:lunasea/core.dart';

class TautulliLogsLoginsState extends ChangeNotifier {
    TautulliLogsLoginsState(BuildContext context) {
        fetchLogs(context);
    }

    Future<TautulliUserLogins> _logs;
    Future<TautulliUserLogins> get logs => _logs;
    Future<void> fetchLogs(BuildContext context) async {
        if(context.read<TautulliState>().enabled) {
            _logs = context.read<TautulliState>().api.users.getUserLogins(
                length: TautulliDatabaseValue.CONTENT_LOAD_LENGTH.data,
            );
        }
        notifyListeners();
    }
}
