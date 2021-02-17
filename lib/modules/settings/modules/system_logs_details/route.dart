import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:f_logs/f_logs.dart' as FLog;
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsSystemLogsDetailsRouter extends LunaPageRouter {
    SettingsSystemLogsDetailsRouter() : super('/settings/logs/details/:type');

    @override
    Future<void> navigateTo(BuildContext context, { @required String type }) async => LunaRouter.router.navigateTo(context, route(type: type));

    @override
    String route({ @required String type }) => fullRoute.replaceFirst(':type', type);

    @override
    void defineRoute(FluroRouter router) => router.define(
        fullRoute,
        handler: Handler(handlerFunc: (context, params) => _SettingsSystemLogsDetailsRoute(type: params['type'] == null ? 'All' : params['type'][0])),
        transitionType: LunaRouter.transitionType,
    );
}

class _SettingsSystemLogsDetailsRoute extends StatefulWidget {
    final String type;

    _SettingsSystemLogsDetailsRoute({
        Key key,
        @required this.type,
    }) : super(key: key);

    @override
    State<_SettingsSystemLogsDetailsRoute> createState() => _State();
}

class _State extends State<_SettingsSystemLogsDetailsRoute> {
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

    Widget get _appBar => LunaAppBar(title: '${widget.type ?? 'Unknown'} Logs');

    Widget get _body => FutureBuilder(
        future: FLog.FLog.getAllLogsByFilter(logLevels: levels),
        builder: (BuildContext context, AsyncSnapshot<List<FLog.Log>> snapshot) {
            switch(snapshot.connectionState) {
                case ConnectionState.done:
                    if(snapshot.hasError) {
                        LunaLogger().error('Unable to fetch logs', snapshot.error, StackTrace.current);
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
