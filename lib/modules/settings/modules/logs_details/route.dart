import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:f_logs/f_logs.dart' as FLog;
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsLogsDetailsRouteArguments {
    final String type;

    SettingsLogsDetailsRouteArguments({
        @required this.type,
    });
}

class SettingsLogsDetailsRoute extends StatefulWidget {
    static const ROUTE_NAME = '/settings/logs/details';

    @override
    State<SettingsLogsDetailsRoute> createState() => _State();
}

class _State extends State<SettingsLogsDetailsRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    SettingsLogsDetailsRouteArguments _arguments;
    List<String> levels = [];

    @override
    void initState() {
        super.initState();
        SchedulerBinding.instance.scheduleFrameCallback((_) async {
            _arguments = ModalRoute.of(context).settings.arguments;
            _setLogLevel();
            setState(() {});
        });
    }

    void _setLogLevel() {
        switch(_arguments?.type) {
            case 'All': levels = []; break;
            case 'Warning': levels = [FLog.LogLevel.WARNING.toString()]; break;
            case 'Error': levels = [FLog.LogLevel.ERROR.toString()]; break;
            case 'Fatal': levels = [FLog.LogLevel.FATAL.toString()]; break;
            default: levels = []; break;
        }
    }

    @override
    Widget build(BuildContext context) => _arguments == null
        ? Scaffold()
        : Scaffold(
            key: _scaffoldKey,
            appBar: _appBar,
            body: _body,
        );

    Widget get _appBar => LSAppBar(title: '${_arguments?.type ?? 'Unknown'} Logs');

    Widget get _body => FutureBuilder(
        future: FLog.FLog.getAllLogsByFilter(logLevels: levels),
        builder: (BuildContext context, AsyncSnapshot<List<FLog.Log>> snapshot) {
            switch(snapshot.connectionState) {
                case ConnectionState.done:
                    if(snapshot.hasError) {
                        Logger.error(
                            'SettingsLogsDetailsRoute',
                            '_body',
                            'Unable to fetch logs',
                            snapshot.error,
                            StackTrace.current,
                        );
                        return LSErrorMessage(onTapHandler: () => {});
                    }
                    if(snapshot.hasData) return snapshot.data.length == 0
                        ? _noLogs
                        : _list(snapshot.data);
                    break;
                case ConnectionState.none:
                case ConnectionState.waiting:
                case ConnectionState.active:
                default: return LSLoader();
            }
            return LSLoader();
        },
    );

    Widget _list(List<FLog.Log> logs) => LSListViewBuilder(
        itemCount: logs.length,
        itemBuilder: (context, index) => SettingsLogsDetailsLogTile(log: logs[index])
    );
    
    Widget get _noLogs => LSGenericMessage(text: 'No Logs Found');
}