import 'package:fluro_fork/fluro_fork.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsModulesSearchAddRoute extends StatefulWidget {
    static const ROUTE_NAME = '/settings/modules/search/add';
    static String route() => ROUTE_NAME;

    static void defineRoute(Router router) => router.define(
        ROUTE_NAME,
        handler: Handler(handlerFunc: (context, params) => SettingsModulesSearchAddRoute()),
        transitionType: LunaRouter.transitionType,
    );

    @override
    State<SettingsModulesSearchAddRoute> createState() => _State();
}

class _State extends State<SettingsModulesSearchAddRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    IndexerHiveObject indexer = IndexerHiveObject.empty();

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
        body: _body,
    );

    Widget get _appBar => LunaAppBar(
        context: context,
        popUntil: '/settings',
        title: 'Add Indexer',
    );

    Widget get _body => LSListView(
        children: [
            _displayName,
            _apiURL,
            _apiKey,
            _headers,
            LSDivider(),
            _addIndexer,
        ],
    );

    Widget get _displayName => LSCardTile(
        title: LSTitle(text: 'Display Name'),
        subtitle: LSSubtitle(
            text: indexer.displayName == null || indexer.displayName.isEmpty
            ? 'Not Set'
            : indexer.displayName,
        ),
        trailing: LSIconButton(icon: Icons.arrow_forward_ios),
        onTap: () async {
            List<dynamic> _values = await LunaDialogs.editText(context, 'Display Name', prefill: indexer.displayName);
            setState(() => indexer.displayName = _values[0]
                ? _values[1]
                : indexer.displayName
            );
        },
    );

    Widget get _apiURL => LSCardTile(
        title: LSTitle(text: 'Indexer API Host'),
        subtitle: LSSubtitle(
            text: indexer.host == null || indexer.host.isEmpty
            ? 'Not Set'
            : indexer.host,
        ),
        trailing: LSIconButton(icon: Icons.arrow_forward_ios),
        onTap: () async {
            List<dynamic> _values = await LunaDialogs.editText(context, 'Indexer API Host', prefill: indexer.host);
            setState(() => indexer.host = _values[0]
                ? _values[1]
                : indexer.host
            );
        },
    );

    Widget get _apiKey => LSCardTile(
        title: LSTitle(text: 'Indexer API Key'),
        subtitle: LSSubtitle(
            text: indexer.key == null || indexer.key.isEmpty
            ? 'Not Set'
            : indexer.key,
        ),
        trailing: LSIconButton(icon: Icons.arrow_forward_ios),
        onTap: () async {
            List<dynamic> _values = await LunaDialogs.editText(context, 'Indexer API Key', prefill: indexer.key);
            setState(() => indexer.key = _values[0]
                ? _values[1]
                : indexer.key
            );
        },
    );

    Widget get _headers => LSCardTile(
        title: LSTitle(text: 'Custom Headers'),
        subtitle: LSSubtitle(text: 'Add Custom Headers to Requests'),
        trailing: LSIconButton(icon: Icons.arrow_forward_ios),
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => SettingsModulesSearchAddHeadersRoute(indexer: indexer),
        )),
    );

    Widget get _addIndexer => LSButton(
        text: 'Add Indexer',
        onTap: () async => _add(),
    );

    Future<void> _add() async {
        if(indexer.displayName == '' || indexer.host == '' || indexer.key == '') {
            LSSnackBar(
                context: context,
                title: 'Failed to Add Indexer',
                message: 'All fields are required',
                type: SNACKBAR_TYPE.failure,
            );
        } else {
            Database.indexersBox.add(indexer);
            LSSnackBar(
                context: context,
                title: 'Indexer Added',
                message: indexer.displayName,
                type: SNACKBAR_TYPE.success,
            );
            Navigator.of(context).pop();
        }
    }
}
