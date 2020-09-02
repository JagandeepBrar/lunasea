import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsModulesSearchEditRouteArguments {
    final IndexerHiveObject indexer;

    SettingsModulesSearchEditRouteArguments({
        @required this.indexer,
    });
}

class SettingsModulesSearchEditRoute extends StatefulWidget {
    static const ROUTE_NAME = '/settings/modules/search/edit';

    @override
    State<SettingsModulesSearchEditRoute> createState() => _State();
}

class _State extends State<SettingsModulesSearchEditRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    SettingsModulesSearchEditRouteArguments _arguments;

    @override
    void initState() {
        super.initState();
        SchedulerBinding.instance.scheduleFrameCallback((_) => setState(() {
            _arguments = ModalRoute.of(context).settings.arguments;
        }));
    }

    @override
    Widget build(BuildContext context) => _arguments == null
        ? Scaffold()
        : Scaffold(
            key: _scaffoldKey,
            appBar: _appBar,
            body: _body,
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

    Widget get _displayName => LSCardTile(
        title: LSTitle(text: 'Display Name'),
        subtitle: LSSubtitle(
            text: _arguments.indexer.displayName == null || _arguments.indexer.displayName.isEmpty
            ? 'Not Set'
            : _arguments.indexer.displayName,
        ),
        trailing: LSIconButton(icon: Icons.arrow_forward_ios),
        onTap: () async {
            List<dynamic> _values = await GlobalDialogs.editText(context, 'Display Name', prefill: _arguments.indexer.displayName);
            setState(() => _arguments.indexer.displayName = _values[0]
                ? _values[1]
                : _arguments.indexer.displayName
            );
            _arguments.indexer.save();
        },
    );

    Widget get _apiURL => LSCardTile(
        title: LSTitle(text: 'Indexer API Host'),
        subtitle: LSSubtitle(
            text: _arguments.indexer.host == null || _arguments.indexer.host.isEmpty
            ? 'Not Set'
            : _arguments.indexer.host,
        ),
        trailing: LSIconButton(icon: Icons.arrow_forward_ios),
        onTap: () async {
            List<dynamic> _values = await GlobalDialogs.editText(context, 'Indexer API Host', prefill: _arguments.indexer.host);
            setState(() => _arguments.indexer.host = _values[0]
                ? _values[1]
                : _arguments.indexer.host
            );
            _arguments.indexer.save();
        },
    );

    Widget get _apiKey => LSCardTile(
        title: LSTitle(text: 'Indexer API Key'),
        subtitle: LSSubtitle(
            text: _arguments.indexer.key == null || _arguments.indexer.key.isEmpty
            ? 'Not Set'
            : _arguments.indexer.key,
        ),
        trailing: LSIconButton(icon: Icons.arrow_forward_ios),
        onTap: () async {
            List<dynamic> _values = await GlobalDialogs.editText(context, 'Indexer API Key', prefill: _arguments.indexer.key);
            setState(() => _arguments.indexer.key = _values[0]
                ? _values[1]
                : _arguments.indexer.key
            );
            _arguments.indexer.save();
        },
    );

    Widget get _headers => LSCardTile(
        title: LSTitle(text: 'Custom Headers'),
        subtitle: LSSubtitle(text: 'Add Custom Headers to Requests'),
        trailing: LSIconButton(icon: Icons.arrow_forward_ios),
        onTap: () async {
            Navigator.of(context).pushNamed(
                SettingsModulesSearchHeadersRoute.ROUTE_NAME,
                arguments: SettingsModulesSearchHeadersRouteArguments(
                    indexer: _arguments.indexer,
                    saveAfterAction: true,
                ),
            );
            _arguments.indexer.save();
        },
    );

    Widget get _deleteIndexer => LSButton(
        text: 'Delete Indexer',
        backgroundColor: LSColors.red,
        onTap: () async => _delete(),
    );

    Future<void> _delete() async {
        List _values = await SettingsDialogs.deleteIndexer(context);
        if(_values[0]) {
            LSSnackBar(
                context: context,
                title: 'Indexer Deleted',
                message: _arguments.indexer.displayName,
                type: SNACKBAR_TYPE.success,
            );
            _arguments.indexer.delete();
            Navigator.of(context).pop();
        }
    }
}
