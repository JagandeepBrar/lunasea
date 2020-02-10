import 'package:f_logs/f_logs.dart' as FLog;
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class LogDetails extends StatefulWidget {
    final FLog.Log log;

    LogDetails({
        Key key,
        @required this.log,
    }) : super(key: key);

    @override
    State<LogDetails> createState() {
        return _State();
    }
}

class _State extends State<LogDetails> {
    final _scaffoldKey = GlobalKey<ScaffoldState>();

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
                    if(widget.log.exception != 'null') _buildException(),
                    if(widget.log.stacktrace != 'null') _buildStackTrace(),
                ],
                padding: Elements.getListViewPadding(extraBottom: true),
            ),
        );
    }

    Widget _buildPackage() {
        return Card(
            child: ListTile(
                title: Elements.getTitle('Class'),
                subtitle: Elements.getSubtitle(widget.log.className, preventOverflow: true),
            ),
            margin: Elements.getCardMargin(),
            elevation: 4.0,
        );
    }

    Widget _buildMethod() {
        return Card(
            child: ListTile(
                title: Elements.getTitle('Method'),
                subtitle: Elements.getSubtitle(widget.log.methodName, preventOverflow: true),
            ),
            margin: Elements.getCardMargin(),
            elevation: 4.0,
        );
    }

    Widget _buildTimestamp() {
        return Card(
            child: ListTile(
                title: Elements.getTitle('Timestamp'),
                subtitle: Elements.getSubtitle(widget.log.timestamp, preventOverflow: true),
            ),
            margin: Elements.getCardMargin(),
            elevation: 4.0,
        );
    }

    Widget _buildMessage() {
        return Card(
            child: ListTile(
                title: Elements.getTitle('Message'),
                subtitle: Elements.getSubtitle(widget.log.text, preventOverflow: true),
                onTap: () async {
                    SystemDialogs.showTextPreviewPrompt(context, 'Message', widget.log.text);
                },
                trailing: IconButton(
                    icon: Elements.getIcon(Icons.arrow_forward_ios),
                    onPressed: null,
                ),
            ),
            margin: Elements.getCardMargin(),
            elevation: 4.0,
        );
    }

    Widget _buildException() {
        return Card(
            child: ListTile(
                title: Elements.getTitle('Exception'),
                subtitle: Elements.getSubtitle(widget.log.exception, preventOverflow: true),
                onTap: () async {
                    SystemDialogs.showTextPreviewPrompt(context, 'Exception', widget.log.exception, alignLeft: true);
                },
                trailing: IconButton(
                    icon: Elements.getIcon(Icons.arrow_forward_ios),
                    onPressed: null,
                ),
            ),
            margin: Elements.getCardMargin(),
            elevation: 4.0,
        );
    }

    Widget _buildStackTrace() {
        return Card(
            child: ListTile(
                title: Elements.getTitle('Stack Trace'),
                subtitle: Elements.getSubtitle(widget.log.stacktrace, preventOverflow: true),
                onTap: () async {
                    SystemDialogs.showTextPreviewPrompt(context, 'Stack Trace', widget.log.stacktrace, alignLeft: true);
                },
                trailing: IconButton(
                    icon: Elements.getIcon(Icons.arrow_forward_ios),
                    onPressed: null,
                ),
            ),
            margin: Elements.getCardMargin(),
            elevation: 4.0,
        );
    }
}
