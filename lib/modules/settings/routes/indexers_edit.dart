import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core/database.dart';
import 'package:lunasea/core.dart';

class SettingsIndexerEditArguments {
    final IndexerHiveObject indexer;

    SettingsIndexerEditArguments({
        @required this.indexer,
    });
}

class SettingsIndexerEdit extends StatefulWidget {
    static const ROUTE_NAME = '/settings/indexers/edit';
    
    @override
    State<SettingsIndexerEdit> createState() => _State();
}

class _State extends State<SettingsIndexerEdit> {
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    SettingsIndexerEditArguments _arguments;

    @override
    void initState() {
        super.initState();
        SchedulerBinding.instance.addPostFrameCallback((_) {
            _arguments = ModalRoute.of(context).settings.arguments;
            setState(() {});
        });
    }

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
        floatingActionButton: _floatingActionButton,
        body: _arguments == null ? null : _body,
    );

    Widget get _appBar => LSAppBar(title: 'Edit Indexer');

    Widget get _floatingActionButton => LSFloatingActionButton(
        icon: Icons.delete,
        backgroundColor: Colors.red,
        onPressed: _deleteIndexer,
    );

    Widget get _body => LSListView(
        children: <Widget>[
            LSCardTile(
                title: LSTitle(text: 'Display Name'),
                subtitle: LSSubtitle(text: _arguments?.indexer?.displayName == '' ? 'Not Set' : _arguments?.indexer?.displayName ?? ''),
                trailing: LSIconButton(icon: Icons.arrow_forward_ios),
                onTap: () async {
                    List<dynamic> _values = await SystemDialogs.showEditTextPrompt(context, 'Display Name', prefill: _arguments?.indexer?.displayName);
                    setState(() => _arguments?.indexer?.displayName = _values[0]
                        ? _values[1]
                        : _arguments?.indexer?.displayName
                    );
                    _arguments?.indexer?.save();
                }
            ),
            LSCardTile(
                title: LSTitle(text: 'URL'),
                subtitle: LSSubtitle(text: _arguments?.indexer?.host == '' ? 'Not Set' : _arguments?.indexer?.host ?? ''),
                trailing: LSIconButton(icon: Icons.arrow_forward_ios),
                onTap: () async {
                    List<dynamic> _values = await SystemDialogs.showEditTextPrompt(context, 'URL', prefill: _arguments?.indexer?.host);
                    setState(() => _arguments?.indexer?.host = _values[0]
                        ? _values[1]
                        : _arguments?.indexer?.host
                    );
                    _arguments?.indexer?.save();
                }
            ),
            LSCardTile(
                title: LSTitle(text: 'API Key'),
                subtitle: LSSubtitle(text: _arguments?.indexer?.key == '' ? 'Not Set' : _arguments?.indexer?.key ?? ''),
                trailing: LSIconButton(icon: Icons.arrow_forward_ios),
                onTap: () async {
                    List<dynamic> _values = await SystemDialogs.showEditTextPrompt(context, 'API Key', prefill: _arguments?.indexer?.key);
                    setState(() => _arguments?.indexer?.key = _values[0]
                        ? _values[1]
                        : _arguments?.indexer?.key
                    );
                    _arguments?.indexer?.save();
                }
            ),
        ],
    );

    Future<void> _deleteIndexer() async {
        List _values = await LSDialogSettings.deleteIndexer(context);
        if(_values[0]) {
            _arguments?.indexer?.delete();
            Navigator.of(context).pop(['indexer_deleted', _arguments?.indexer?.displayName]);
        }
    }
}
