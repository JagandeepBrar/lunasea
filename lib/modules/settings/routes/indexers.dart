import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import '../../settings.dart';

class SettingsIndexers extends StatefulWidget {
    static const ROUTE_NAME = '/settings/indexers';

    @override
    State<SettingsIndexers> createState() => _State();
}

class _State extends State<SettingsIndexers> {
    final _scaffoldKey = GlobalKey<ScaffoldState>();

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: LSAppBar(title: 'Settings'),
        body: ValueListenableBuilder(
            valueListenable: Database.indexersBox.listenable(),
            builder: (context, box, widget) => _body,
        ),
    );

    Widget get _body => LSListView(
        customPadding: EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 92.0),
        children: <Widget>[
            LSCardTile(
                title: LSTitle(text: 'Add Indexer'),
                subtitle: LSSubtitle(text: 'Add a new indexer to LunaSea'),
                trailing: LSIconButton(icon: Icons.add),
                onTap: _enterAddIndexer,
            ),
            LSDivider(),
            if(Database.indexersBox.length == 0) LSGenericMessage(text: 'No Indexers Added'),
            ..._indexerList,
        ],
    );

    List get _indexerList {
        List list = List.generate(Database.indexersBox.length, (index) {
            IndexerHiveObject indexer = Database.indexersBox.getAt(index);
            return LSCardTile(
                title: LSTitle(text: indexer.displayName),
                subtitle: LSSubtitle(text: indexer.host),
                trailing: LSIconButton(icon: Icons.arrow_forward_ios),
                onTap: () => _enterEditIndexer(indexer),
            );
        });
        list.sort((a,b) => (a.title as LSTitle).text.compareTo((b.title as LSTitle).text));
        return list;
    }

    Future<void> _enterAddIndexer() async {
        final dynamic result = await Navigator.of(context).pushNamed(SettingsIndexersAdd.ROUTE_NAME);
        if(result != null && result[0] == 'indexer_added')
            LSSnackBar(context: context, title: 'Indexer Added', message: result[1], type: SNACKBAR_TYPE.success);
    }

    Future<void> _enterEditIndexer(IndexerHiveObject indexer) async {
        final dynamic result = await Navigator.of(context).pushNamed(
            SettingsIndexerEdit.ROUTE_NAME,
            arguments: SettingsIndexerEditArguments(indexer: indexer),
        );
        if(result != null && result[0] == 'indexer_deleted')
            LSSnackBar(context: context, title: 'Indexer Deleted', message: result[1], type: SNACKBAR_TYPE.success);
    }
}
