import 'package:f_logs/f_logs.dart' as FLog;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core.dart';

class SettingsGeneralLogsDetailsArguments {
    final FLog.Log log;

    SettingsGeneralLogsDetailsArguments({
        @required this.log,
    });
}

class SettingsGeneralLogsDetails extends StatefulWidget {
    static const ROUTE_NAME = '/settings/general/logs/details';

    @override
    State<SettingsGeneralLogsDetails> createState() => _State();
}

class _State extends State<SettingsGeneralLogsDetails> {
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    SettingsGeneralLogsDetailsArguments _arguments;

    @override
    void initState() {
        super.initState();
        SchedulerBinding.instance.addPostFrameCallback((_) => 
            setState(() => _arguments = ModalRoute.of(context).settings.arguments)
        );
    }

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
        body: _arguments == null ? null : _body,
    );

    Widget get _appBar => LSAppBar(title: 'Log Details');

    Widget get _body => LSListView(
        children: <Widget>[
            LSCardTile(
                title: LSTitle(text: 'Class'),
                subtitle: LSSubtitle(text: _arguments?.log?.className ?? 'Unknown', maxLines: 1),
            ),
            LSCardTile(
                title: LSTitle(text: 'Method'),
                subtitle: LSSubtitle(text: _arguments?.log?.methodName ?? 'Unknown', maxLines: 1),
            ),
            LSCardTile(
                title: LSTitle(text: 'Timestamp'),
                subtitle: LSSubtitle(text: _arguments?.log?.timestamp ?? 'Unknown', maxLines: 1),
            ),
            LSCardTile(
                title: LSTitle(text: 'Message'),
                subtitle: LSSubtitle(text: _arguments?.log?.text ?? 'Unknown', maxLines: 1),
                trailing: LSIconButton(icon: Icons.arrow_forward_ios),
                onTap: () async => GlobalDialogs.textPreview(context, 'Message', _arguments?.log?.text),
            ),
            if(_arguments?.log?.exception != 'null') LSCardTile(
                title: LSTitle(text: 'Exception'),
                subtitle: LSSubtitle(text: _arguments?.log?.exception ?? 'Unknown', maxLines: 1),
                trailing: LSIconButton(icon: Icons.arrow_forward_ios),
                onTap: () async => GlobalDialogs.textPreview(context, 'Exception', _arguments?.log?.exception, alignLeft: true),
            ),
            if(_arguments?.log?.stacktrace != 'null') LSCardTile(
                title: LSTitle(text: 'Stack Trace'),
                subtitle: LSSubtitle(text: _arguments?.log?.stacktrace ?? 'Unknown', maxLines: 1),
                trailing: LSIconButton(icon: Icons.arrow_forward_ios),
                onTap: () async => GlobalDialogs.textPreview(context, 'Stack Trace', _arguments?.log?.stacktrace, alignLeft: true),
            ),
        ],
    );
}
