import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class SettingsModulesSonarrHeaders extends StatefulWidget {
    static const ROUTE_NAME = '/settings/modules/sonarr/headers';
    
    @override
    State<SettingsModulesSonarrHeaders> createState() => _State();
}

class _State extends State<SettingsModulesSonarrHeaders> {
    @override
    Widget build(BuildContext context) => Scaffold(
        appBar: _appBar,
        body: _body,
    );

    Widget get _appBar => LSAppBar(title: 'Custom Headers');

    Widget get _body => LSListView(
        children: <Widget>[
            ..._headers,
        ],
    );

    List<Widget> get _headers => [
        LSHeader(
            text: 'Custom Headers',
            subtitle: 'Define custom headers that will be attached to every request made to the module.',
        ),
        if((Database.currentProfileObject.getSonarr()['headers'] as Map).isEmpty) LSGenericMessage(
            text: 'No Custom Headers Added',
        ),
        ..._list,
        LSDivider(),
        LSButton(
            text: 'Add Header',
            onTap: () async => _showAddPrompt(),
        ),
    ];

    List get _list {
        Map headers = Database.currentProfileObject.getSonarr()['headers'];
        List list = [];
        headers.forEach((key, value) => list.add(LSCardTile(
            title: LSTitle(text: key.toString()),
            subtitle: LSSubtitle(text: value.toString()),
        )));
        list.sort((a,b) => (a.title as LSTitle).text.compareTo((b.title as LSTitle).text));
        return list;
    }

    Future<void> _showAddPrompt() async {
        List results = await LSDialogSettings.addHeader(context);
    }
}