import 'package:f_logs/f_logs.dart' as FLog;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lunasea/widgets/ui.dart';

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
    SettingsGeneralLogsDetailsArguments arguments;

    @override
    void initState() {
        super.initState();
        SchedulerBinding.instance.addPostFrameCallback((_) => setState(() => arguments = ModalRoute.of(context).settings.arguments));
    }

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: LSAppBar(title: 'Log Details'),
        body: _body,
    );

    Widget get _body => LSListView(
        children: <Widget>[
            LSCardTile(
                title: LSTitle(text: 'Class'),
                subtitle: LSSubtitle(text: arguments?.log?.className ?? 'Unknown', maxLines: 1),
            ),
            LSCardTile(
                title: LSTitle(text: 'Method'),
                subtitle: LSSubtitle(text: arguments?.log?.methodName ?? 'Unknown', maxLines: 1),
            ),
            LSCardTile(
                title: LSTitle(text: 'Timestamp'),
                subtitle: LSSubtitle(text: arguments?.log?.timestamp ?? 'Unknown', maxLines: 1),
            ),
            LSCardTile(
                title: LSTitle(text: 'Message'),
                subtitle: LSSubtitle(text: arguments?.log?.text ?? 'Unknown', maxLines: 1),
                trailing: LSIconButton(icon: Icons.arrow_forward_ios),
                onTap: () async => SystemDialogs.showTextPreviewPrompt(context, 'Message', arguments?.log?.text),
            ),
            if(arguments?.log?.exception != 'null') LSCardTile(
                title: LSTitle(text: 'Exception'),
                subtitle: LSSubtitle(text: arguments?.log?.exception ?? 'Unknown', maxLines: 1),
                trailing: LSIconButton(icon: Icons.arrow_forward_ios),
                onTap: () async => SystemDialogs.showTextPreviewPrompt(context, 'Exception', arguments?.log?.exception, alignLeft: true),
            ),
            if(arguments?.log?.stacktrace != 'null') LSCardTile(
                title: Elements.getTitle('Stack Trace'),
                subtitle: LSSubtitle(text: arguments?.log?.stacktrace ?? 'Unknown', maxLines: 1),
                trailing: LSIconButton(icon: Icons.arrow_forward_ios),
                onTap: () async => SystemDialogs.showTextPreviewPrompt(context, 'Stack Trace', arguments?.log?.stacktrace, alignLeft: true),
            ),
        ],
        padBottom: true,
    );
}
