import 'package:f_logs/f_logs.dart' as FLog;
import 'package:flutter/material.dart';
import 'package:lunasea/system/ui.dart';

class LogDetails extends StatelessWidget {
    final FLog.Log log;

    LogDetails({
        Key key,
        @required this.log,
    }) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return _LogDetailsWidget(log: log);
    }
}

class _LogDetailsWidget extends StatefulWidget {
    final FLog.Log log;

    _LogDetailsWidget({
        Key key,
        @required this.log,
    }) : super(key: key);

    @override
    State<StatefulWidget> createState() {
        return _LogDetailsState(log: log);
    }
}

class _LogDetailsState extends State<StatefulWidget> {
    final FLog.Log log;
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    
    _LogDetailsState({
        Key key,
        @required this.log,
    });

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            key: _scaffoldKey,
            appBar: Navigation.getAppBar('Log Details', context),
            body: _buildDetails(),
        );
    }

    Widget _buildDetails() {
        return Scrollbar(
            child: ListView(
                children: <Widget>[
                    _buildPackage(),
                    _buildMethod(),
                    _buildTimestamp(),
                    _buildMessage(),
                    if(log.exception != 'null') _buildException(),
                    if(log.stacktrace != 'null') _buildStackTrace(),
                ],
                padding: Elements.getListViewPadding(extraBottom: true),
            ),
        );
    }

    Widget _buildPackage() {
        return Card(
            child: ListTile(
                title: Elements.getTitle('Class'),
                subtitle: Elements.getSubtitle(log.className, preventOverflow: true),
                onTap: () async {
                    SystemDialogs.showTextPreviewPrompt(context, 'Class', log.className);
                },
            ),
            margin: Elements.getCardMargin(),
            elevation: 4.0,
        );
    }

    Widget _buildMethod() {
        return Card(
            child: ListTile(
                title: Elements.getTitle('Method'),
                subtitle: Elements.getSubtitle(log.methodName, preventOverflow: true),
                onTap: () async {
                    SystemDialogs.showTextPreviewPrompt(context, 'Method', log.methodName);
                },
            ),
            margin: Elements.getCardMargin(),
            elevation: 4.0,
        );
    }

    Widget _buildTimestamp() {
        return Card(
            child: ListTile(
                title: Elements.getTitle('Timestamp'),
                subtitle: Elements.getSubtitle(log.timestamp, preventOverflow: true),
                onTap: () async {
                    SystemDialogs.showTextPreviewPrompt(context, 'Timestamp', log.timestamp);
                },
            ),
            margin: Elements.getCardMargin(),
            elevation: 4.0,
        );
    }

    Widget _buildMessage() {
        return Card(
            child: ListTile(
                title: Elements.getTitle('Message'),
                subtitle: Elements.getSubtitle(log.text, preventOverflow: true),
                onTap: () async {
                    SystemDialogs.showTextPreviewPrompt(context, 'Message', log.text);
                },
            ),
            margin: Elements.getCardMargin(),
            elevation: 4.0,
        );
    }

    Widget _buildException() {
        return Card(
            child: ListTile(
                title: Elements.getTitle('Exception'),
                subtitle: Elements.getSubtitle(log.exception, preventOverflow: true),
                onTap: () async {
                    SystemDialogs.showTextPreviewPrompt(context, 'Exception', log.exception, alignLeft: true);
                },
            ),
            margin: Elements.getCardMargin(),
            elevation: 4.0,
        );
    }

    Widget _buildStackTrace() {
        return Card(
            child: ListTile(
                title: Elements.getTitle('Stack Trace'),
                subtitle: Elements.getSubtitle(log.stacktrace, preventOverflow: true),
                onTap: () async {
                    SystemDialogs.showTextPreviewPrompt(context, 'Stack Trace', log.stacktrace, alignLeft: true);
                },
            ),
            margin: Elements.getCardMargin(),
            elevation: 4.0,
        );
    }
}
