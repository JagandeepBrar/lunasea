import 'package:f_logs/f_logs.dart' as FLog;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsGeneralLogsViewArguments {
    final String type;
    
    SettingsGeneralLogsViewArguments({
        @required this.type
    });
}

class SettingsGeneralLogsView extends StatefulWidget {
    static const ROUTE_NAME = '/settings/general/logs/view';
    
    @override
    State<SettingsGeneralLogsView> createState() => _State();
}

class _State extends State<SettingsGeneralLogsView> {
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    SettingsGeneralLogsViewArguments _arguments;
    List<FLog.Log> _logs = [];
    List<String> levels = [];

    @override
    void initState() {
        super.initState();
        SchedulerBinding.instance.addPostFrameCallback((_) async {
            _arguments = ModalRoute.of(context).settings.arguments;
            _setLogLevel();
            await _fetchLogs();
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

    Future<void> _fetchLogs() async {
        _logs = await FLog.FLog.getAllLogsByFilter(logLevels: levels);
        _logs.sort((a, b) => b.timeInMillis.compareTo(a.timeInMillis));
    }

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
        body: _arguments == null ? null : _body,
    );

    Widget get _appBar => LSAppBar(title: '${_arguments?.type} Logs');

    Widget get _body => _logs.length == 0
        ? LSGenericMessage(text: 'No Logs Found')
        : LSListViewBuilder(
            itemCount: _logs.length,
            itemBuilder: (context, index) => _entry(_logs[index]),
        );

    Widget _entry(FLog.Log log) => LSCardTile(
        title: LSTitle(text: log.text),
        subtitle: RichText(
            text: TextSpan(
                style: TextStyle(
                    color: Colors.white70,
                    fontSize: Constants.UI_FONT_SIZE_SUBTITLE,
                ),
                children: <TextSpan>[
                    TextSpan(text: log.timestamp),
                    TextSpan(
                        text: '\n${log.logLevel.lsFLogLogLevel_name()}',
                        style: TextStyle(
                            color: log.logLevel.lsFLogLogLevel_color(),
                            fontWeight: FontWeight.bold,
                        ),
                    )
                    //_getLogLevel(log.logLevel),
                ],
            ),
        ),
        trailing: LSIconButton(icon: Icons.arrow_forward_ios),
        onTap: () async => _logDetails(log),
        padContent: true,
    );

    Future<void> _logDetails(FLog.Log log) async => await Navigator.of(context).pushNamed(
        SettingsGeneralLogsDetails.ROUTE_NAME,
        arguments: SettingsGeneralLogsDetailsArguments(log: log),
    );
}
