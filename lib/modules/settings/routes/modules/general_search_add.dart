import 'package:flutter/material.dart';
import 'package:lunasea/core/database.dart';
import 'package:lunasea/core.dart';

class SettingsModulesSearchAdd extends StatefulWidget {
    static const ROUTE_NAME = '/settings/modules/search/add';
    
    @override
    State<SettingsModulesSearchAdd> createState() => _State();
}

class _State extends State<SettingsModulesSearchAdd> {
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    IndexerHiveObject indexer = IndexerHiveObject.empty();

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
        body: _body,
    );

    Widget get _appBar => LSAppBar(title: 'Add Indexer');

    Widget get _body => LSListView(
        children: <Widget>[
            LSCardTile(
                title: LSTitle(text: 'Display Name'),
                subtitle: LSSubtitle(text: indexer.displayName == '' ? 'Not Set' : indexer.displayName),
                trailing: LSIconButton(icon: Icons.arrow_forward_ios),
                onTap: () async {
                    List<dynamic> _values = await GlobalDialogs.editText(context, 'Display Name', prefill: indexer.displayName);
                    setState(() => indexer.displayName = _values[0]
                        ? _values[1]
                        : indexer.displayName
                    );
                }
            ),
            LSCardTile(
                title: LSTitle(text: 'Indexer API URL'),
                subtitle: LSSubtitle(text: indexer.host == '' ? 'Not Set' : indexer.host),
                trailing: LSIconButton(icon: Icons.arrow_forward_ios),
                onTap: () async {
                    List<dynamic> _values = await GlobalDialogs.editText(context, 'Indexer API URL', prefill: indexer.host);
                    setState(() => indexer.host = _values[0]
                        ? _values[1]
                        : indexer.host
                    );
                }
            ),
            LSCardTile(
                title: LSTitle(text: 'Indexer API Key'),
                subtitle: LSSubtitle(text: indexer.key == '' ? 'Not Set' : indexer.key),
                trailing: LSIconButton(icon: Icons.arrow_forward_ios),
                onTap: () async {
                    List<dynamic> _values = await GlobalDialogs.editText(context, 'Indexer API Key', prefill: indexer.key);
                    setState(() => indexer.key = _values[0]
                        ? _values[1]
                        : indexer.key
                    );
                }
            ),
            LSDivider(),
            LSButton(
                text: 'Add Indexer',
                onTap: () => _addIndexer(),
            ),
        ],
    );

    void _addIndexer() {
        if(indexer.displayName == '' || indexer.host == '' || indexer.key == '') {
            LSSnackBar(
                context: context,
                title: 'Failed to Add Indexer',
                message: 'All fields are required',
                type: SNACKBAR_TYPE.failure,
            );
        } else {
            Database.indexersBox.add(indexer);
            Navigator.of(context).pop(['indexer_added', indexer.displayName]);
        }
    }
}
