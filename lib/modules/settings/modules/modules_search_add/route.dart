import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsModulesSearchAddRouter {
    static const ROUTE_NAME = '/settings/modules/search/add';

    static Future<void> navigateTo(BuildContext context, [List parameters]) async => LunaRouter.router.navigateTo(
        context,
        route(),
    );

    static String route() => ROUTE_NAME;
    
    static void defineRoutes(FluroRouter router) => router.define(
        ROUTE_NAME,
        handler: Handler(handlerFunc: (context, params) => _SettingsModulesSearchAddRoute()),
        transitionType: LunaRouter.transitionType,
    );

    SettingsModulesSearchAddRouter._();
}

class _SettingsModulesSearchAddRoute extends StatefulWidget {
    @override
    State<_SettingsModulesSearchAddRoute> createState() => _State();
}

class _State extends State<_SettingsModulesSearchAddRoute> {
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
        title: 'Add Indexer',
    );

    Widget get _body => LSListView(
        children: [
            _displayName,
            _apiURL,
            _apiKey,
            _headers,
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
            showLunaErrorSnackBar(
                context: context,
                title: 'Failed to Add Indexer',
                message: 'All fields are required',
            );
        } else {
            Database.indexersBox.add(indexer);
            showLunaSuccessSnackBar(
                context: context,
                title: 'Indexer Added',
                message: indexer.displayName,
            );
            Navigator.of(context).pop();
        }
    }
}
