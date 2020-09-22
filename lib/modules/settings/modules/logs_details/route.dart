import 'package:fluro_fork/fluro_fork.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:f_logs/f_logs.dart' as FLog;
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsLogsDetailsRoute extends StatefulWidget {
    final String type;

    static const ROUTE_NAME = '/settings/logs/details/:type';
    static String route({
        @required String type,
    }) => ROUTE_NAME.replaceFirst(':type', type);

    static void defineRoute(Router router) => router.define(
        ROUTE_NAME,
        handler: Handler(handlerFunc: (context, params) => SettingsLogsDetailsRoute(
            type: params['type'][0],
        )),
        transitionType: LunaRouter.transitionType,
    );

    SettingsLogsDetailsRoute({
        Key key,
        @required this.type,
    }) : super(key: key);

    @override
    State<SettingsLogsDetailsRoute> createState() => _State();
}

class _State extends State<SettingsLogsDetailsRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    List<String> levels = [];

    @override
    void initState() {
        super.initState();
        _setLogLevel();
    }

    void _setLogLevel() {
        switch(widget.type) {
            case 'All': levels = []; break;
            case 'Warning': levels = [FLog.LogLevel.WARNING.toString()]; break;
            case 'Error': levels = [FLog.LogLevel.ERROR.toString()]; break;
            case 'Fatal': levels = [FLog.LogLevel.FATAL.toString()]; break;
            default: levels = []; break;
        }
    }

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
        body: _body,
    );

    Widget get _appBar => LSAppBar(title: '${widget.type ?? 'Unknown'} Logs');

    Widget get _body => FutureBuilder(
        future: FLog.FLog.getAllLogsByFilter(logLevels: levels),
        builder: (BuildContext context, AsyncSnapshot<List<FLog.Log>> snapshot) {
            switch(snapshot.connectionState) {
                case ConnectionState.done:
                    if(snapshot.hasError) {
                        LunaLogger.error(
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
                        : _list(snapshot.data.reversed.toList());
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
        itemBuilder: (context, index) => SettingsLogsDetailsLogTile(log: logs[index]),
    );
    
    Widget get _noLogs => LSGenericMessage(text: 'No Logs Found');
}
