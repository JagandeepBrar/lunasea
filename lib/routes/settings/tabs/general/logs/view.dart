import 'package:f_logs/f_logs.dart' as FLog;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/system/extensions.dart';
import 'package:lunasea/routes/settings/routes.dart';
import 'package:lunasea/widgets/ui.dart';
import './details.dart';

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
    SettingsGeneralLogsViewArguments arguments;
    List<FLog.Log> _logs = [];
    List<String> levels = [];

    @override
    void initState() {
        super.initState();
        SchedulerBinding.instance.addPostFrameCallback((_) {
            setState(() => arguments = ModalRoute.of(context).settings.arguments);
            _setLogLevel();
            _fetchLogs();
        });
    }

    void _setLogLevel() {
        switch(arguments?.type) {
            case 'All': levels = []; break;
            case 'Warning': levels = [FLog.LogLevel.WARNING.toString()]; break;
            case 'Error': levels = [FLog.LogLevel.ERROR.toString()]; break;
            case 'Fatal': levels = [FLog.LogLevel.FATAL.toString()]; break;
            default: levels = []; break;
        }
    }

    Future<void> _fetchLogs() async {
        _logs = await FLog.FLog.getAllLogsByFilter(logLevels: levels);
        setState(() => _logs.sort((a, b) => b.timeInMillis.compareTo(a.timeInMillis)));
    }

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: LSAppBar(title: '${arguments?.type} Logs'),
        body: _body,
    );

    Widget get _body => _logs.length == 0
        ? LSGenericMessage(text: 'No Logs Found')
        : LSListViewBuilder(
            itemCount: _logs.length,
            itemBuilder: (context, index) => _entry(_logs[index]),
            padBottom: true,
        );

    Widget _entry(FLog.Log log) => LSCardTile(
        title: LSTitle(text: log.text),
        subtitle: RichText(
            text: TextSpan(
                style: TextStyle(
                    color: Colors.white70,
                    letterSpacing: Constants.UI_LETTER_SPACING,
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
