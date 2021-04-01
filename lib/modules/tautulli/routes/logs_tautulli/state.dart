import 'package:flutter/material.dart';
import 'package:lunasea/modules/tautulli.dart';
import 'package:lunasea/core.dart';

class TautulliLogsTautulliState extends ChangeNotifier {
    TautulliLogsTautulliState(BuildContext context) {
        fetchLogs(context);
    }

    Future<List<TautulliLog>> _logs;
    Future<List<TautulliLog>> get logs => _logs;
    Future<void> fetchLogs(BuildContext context) async {
        if(context.read<TautulliState>().enabled) {
            _logs = context.read<TautulliState>().api.miscellaneous.getLogs(
                start: 0,
                end: TautulliDatabaseValue.CONTENT_LOAD_LENGTH.data,
            );
        }
        notifyListeners();
    }
}
