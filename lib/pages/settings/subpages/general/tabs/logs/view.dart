import 'package:f_logs/f_logs.dart' as FLog;
import 'package:flutter/material.dart';
import 'package:lunasea/pages/settings/subpages/general/tabs/logs/details.dart';
import 'package:lunasea/core.dart';

class ViewLogs extends StatefulWidget {
    final String type;

    ViewLogs({
        Key key,
        @required this.type,
    }) : super(key: key);

    @override
    State<ViewLogs> createState() {
        return _State();
    }
}

class _State extends State<ViewLogs> {
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    bool _loading = true;
    List<FLog.Log> _logs;
    List<String> levels;

    @override
    void initState() {
        super.initState();
        _setLogLevel();
        _fetchLogs();
    }

    void _setLogLevel() {
        switch(widget.type) {
            case 'All': { levels = []; break; }
            case 'Warning': { levels = [FLog.LogLevel.WARNING.toString()]; break; }
            case 'Error': { levels = [FLog.LogLevel.ERROR.toString()]; break; }
            case 'Fatal': { levels = [FLog.LogLevel.FATAL.toString()]; break; }
            default: { levels = null; break; }
        }
    }

    TextSpan _getLogLevel(FLog.LogLevel level) {
        switch(level.toString()) {
            case 'LogLevel.WARNING': {
                return TextSpan(
                    text: '\nWARNING',
                    style: TextStyle(
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                    ),
                );
            }
            case 'LogLevel.ERROR': {
                return TextSpan(
                    text: '\nERROR',
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                    ),
                );
            }
            case 'LogLevel.FATAL': {
                return TextSpan(
                    text: '\nFATAL',
                    style: TextStyle(
                        color: Color(Constants.ACCENT_COLOR),
                        fontWeight: FontWeight.bold,
                    ),
                );
            }
            default: {
                return TextSpan(
                    text: '\nUNKNOWN',
                    style: TextStyle(
                        color: Colors.blueGrey,
                        fontWeight: FontWeight.bold,
                    ),
                );
            }
        }
    }

    Future<void> _fetchLogs() async {
        if(mounted) {
            setState(() {
                _loading = true;
            });
        }
        _logs = await FLog.FLog.getAllLogsByFilter(
            logLevels: levels,
        );
        _logs.sort((a, b) => b.timeInMillis.compareTo(a.timeInMillis));
        if(mounted) {
            setState(() {
                _loading = false;
            });
        }
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            key: _scaffoldKey,
            appBar: Navigation.getAppBar('${widget.type} Logs', context),
            body: _loading ?
                Notifications.centeredMessage('Loading...') :
                _logs == null ?
                    Notifications.centeredMessage('An Error has Occurred') :
                    _logs.length == 0 ?
                        Notifications.centeredMessage('No Logs Found') :
                        _buildLogList(),
        );
    }

    Widget _buildLogList() {
        return Scrollbar(
            child: ListView.builder(
                itemCount: _logs.length,
                itemBuilder: (context, index) {
                    return _buildEntry(_logs[index]);
                },
                padding: Elements.getListViewPadding(extraBottom: true),
            ),
        );
    }

    Widget _buildEntry(FLog.Log log) {
        return Card(
            child: ListTile(
                title: Elements.getTitle(log.text),
                subtitle: RichText(
                    text: TextSpan(
                        style: TextStyle(
                                color: Colors.white70,
                                letterSpacing: Constants.LETTER_SPACING,
                            ),
                        children: [
                            TextSpan(
                                text: '${log.timestamp}',
                            ),
                            _getLogLevel(log.logLevel),
                        ],
                    ),
                    
                ),
                trailing: IconButton(
                    icon: Elements.getIcon(Icons.arrow_forward_ios),
                    onPressed: null,
                ),
                onTap: () async {
                    await _logDetails(log);
                },
                contentPadding: Elements.getContentPadding(),
            ),
            margin: Elements.getCardMargin(),
            elevation: 4.0,
        );
    }

    Future<void> _logDetails(FLog.Log log) async {
        await Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => LogDetails(log: log),
            ),
        );
    }
}
