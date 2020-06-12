import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsSystemChangelog extends StatefulWidget {
    static const ROUTE_NAME = '/settings/system/changelog';

    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<SettingsSystemChangelog> {
    final GlobalKey<RefreshIndicatorState> _refreshKey = GlobalKey<RefreshIndicatorState>();
    Future<List> _future;
    List _changes = [];

    @override
    void initState() {
        super.initState();
        _refresh();
    }

    Future<void> _refresh() async {
        _changes = [];
        if(mounted) setState(() => { _future = SettingsAPI.getChangelog() });
    }

    @override
    Widget build(BuildContext context) => Scaffold(
        appBar: _appBar,
        body: _body,
    );

    Widget get _body => LSRefreshIndicator(
        refreshKey: _refreshKey,
        onRefresh: () => _refresh(),
        child: FutureBuilder(
            future: _future,
            builder: (context, snapshot) {
                switch(snapshot.connectionState) {
                    case ConnectionState.done: {
                        if(snapshot.hasError || snapshot.data == null) return LSErrorMessage(onTapHandler: () => _refresh());
                        _changes = snapshot.data;
                        return _list;
                    }
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                    case ConnectionState.active:
                    default: return LSLoading();
                }
            },
        ),
    );

    Widget get _list => _changes.length == 0
        ? LSGenericMessage(text: 'No Changes Found')
        : LSListViewBuilder(
            itemCount: _changes.length,
            itemBuilder: (context, index) => LSCardTile(
                title: LSTitle(text: _changes[index]['version']),
                subtitle: LSSubtitle(text: _changes[index]['date']),
                trailing: LSIconButton(icon: Icons.arrow_forward_ios),
                onTap: () async => Navigator.of(context).pushNamed(
                    SettingsSystemChangelogDetails.ROUTE_NAME,
                    arguments: SettingsSystemChangelogDetailsArguments(details: _changes[index]),
                ),
            ),
        );

    Widget get _appBar => LSAppBar(title: 'Changelog');
}
