import 'package:fluro_fork/fluro_fork.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsModulesSearchEditRoute extends StatefulWidget {
    final int index;

    static const ROUTE_NAME = '/settings/modules/search/edit/:index';
    static String route({
        @required int index,
    }) => ROUTE_NAME.replaceFirst(':index', index.toString());

    static void defineRoute(Router router) => router.define(
        ROUTE_NAME,
        handler: Handler(handlerFunc: (context, params) => SettingsModulesSearchEditRoute(
            index: int.tryParse(params['index'][0]),
        )),
        transitionType: LunaRouter.transitionType,
    );

    SettingsModulesSearchEditRoute({
        Key key,
        @required this.index,
    }) : super(key: key);

    @override
    State<SettingsModulesSearchEditRoute> createState() => _State();
}

class _State extends State<SettingsModulesSearchEditRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    IndexerHiveObject _indexer;

    @override
    void initState() {
        super.initState();
        _fetchIndexer();
    }

    void _fetchIndexer() {
        try {
            _indexer = Database.indexersBox.getAt(widget.index);
        } catch (_) {
            LunaLogger.warning(
                'SettingsModulesSearchEditRoute',
                '_fetchIndexer',
                'Unable to fetch indexer',
            );
        }
    }

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
        body: _indexer != null ? _body : _indexerNotFound,
    );

    Widget get _appBar => LSAppBar(title: 'Edit Indexer');

    Widget get _body => LSListView(
        children: [
            _displayName,
            _apiURL,
            _apiKey,
            _headers,
            LSDivider(),
            _deleteIndexer,
        ],
    );

    Widget get _indexerNotFound => LSGenericMessage(text: 'Indexer Not Found');

    Widget get _displayName => LSCardTile(
        title: LSTitle(text: 'Display Name'),
        subtitle: LSSubtitle(
            text: _indexer.displayName == null || _indexer.displayName.isEmpty
            ? 'Not Set'
            : _indexer.displayName,
        ),
        trailing: LSIconButton(icon: Icons.arrow_forward_ios),
        onTap: () async {
            List<dynamic> _values = await GlobalDialogs.editText(context, 'Display Name', prefill: _indexer.displayName);
            setState(() => _indexer.displayName = _values[0]
                ? _values[1]
                : _indexer.displayName
            );
            _indexer.save();
        },
    );

    Widget get _apiURL => LSCardTile(
        title: LSTitle(text: 'Indexer API Host'),
        subtitle: LSSubtitle(
            text: _indexer.host == null || _indexer.host.isEmpty
            ? 'Not Set'
            : _indexer.host,
        ),
        trailing: LSIconButton(icon: Icons.arrow_forward_ios),
        onTap: () async {
            List<dynamic> _values = await GlobalDialogs.editText(context, 'Indexer API Host', prefill: _indexer.host);
            setState(() => _indexer.host = _values[0]
                ? _values[1]
                : _indexer.host
            );
            _indexer.save();
        },
    );

    Widget get _apiKey => LSCardTile(
        title: LSTitle(text: 'Indexer API Key'),
        subtitle: LSSubtitle(
            text: _indexer.key == null || _indexer.key.isEmpty
            ? 'Not Set'
            : _indexer.key,
        ),
        trailing: LSIconButton(icon: Icons.arrow_forward_ios),
        onTap: () async {
            List<dynamic> _values = await GlobalDialogs.editText(context, 'Indexer API Key', prefill: _indexer.key);
            setState(() => _indexer.key = _values[0]
                ? _values[1]
                : _indexer.key
            );
            _indexer.save();
        },
    );

    Widget get _headers => LSCardTile(
        title: LSTitle(text: 'Custom Headers'),
        subtitle: LSSubtitle(text: 'Add Custom Headers to Requests'),
        trailing: LSIconButton(icon: Icons.arrow_forward_ios),
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => SettingsModulesSearchEditHeadersRoute(indexer: _indexer),
        )),
    );

    Widget get _deleteIndexer => LSButton(
        text: 'Delete Indexer',
        backgroundColor: LunaColours.red,
        onTap: () async => _delete(),
    );

    Future<void> _delete() async {
        List _values = await SettingsDialogs.deleteIndexer(context);
        if(_values[0]) {
            LSSnackBar(
                context: context,
                title: 'Indexer Deleted',
                message: _indexer.displayName,
                type: SNACKBAR_TYPE.success,
            );
            _indexer.delete();
            Navigator.of(context).pop();
        }
    }
}
