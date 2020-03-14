import 'package:flutter/material.dart';
import 'package:lunasea/core/database.dart';
import 'package:lunasea/widgets/ui.dart';

class SettingsIndexersAdd extends StatefulWidget {
    static const ROUTE_NAME = '/settings/indexers/add';
    
    @override
    State<SettingsIndexersAdd> createState() => _State();
}

class _State extends State<SettingsIndexersAdd> {
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    IndexerHiveObject indexer = IndexerHiveObject.empty();

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
        body: _body,
        floatingActionButton: _floatingActionButton,
    );

    Widget get _appBar => LSAppBar(title: 'Add Indexer');

    Widget get _floatingActionButton => LSFloatingActionButton(
        icon: Icons.add,
        onPressed: () {
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
        },
    );

    Widget get _body => LSListView(
        children: <Widget>[
            LSCardTile(
                title: LSTitle(text: 'Display Name'),
                subtitle: LSSubtitle(text: indexer.displayName == '' ? 'Not Set' : indexer.displayName),
                trailing: LSIconButton(icon: Icons.arrow_forward_ios),
                onTap: () async {
                    List<dynamic> _values = await SystemDialogs.showEditTextPrompt(context, 'Display Name', prefill: indexer.displayName);
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
                    List<dynamic> _values = await SystemDialogs.showEditTextPrompt(context, 'Indexer API URL', prefill: indexer.host);
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
                    List<dynamic> _values = await SystemDialogs.showEditTextPrompt(context, 'Indexer API Key', prefill: indexer.key);
                    setState(() => indexer.key = _values[0]
                        ? _values[1]
                        : indexer.key
                    );
                }
            ),
        ],
    );
}
