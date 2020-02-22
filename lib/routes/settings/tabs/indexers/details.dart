import 'package:flutter/material.dart';
import 'package:lunasea/widgets/ui.dart';

class SettingsIndexerDetails extends StatefulWidget {
    static const ROUTE_NAME = '/settings/indexers/details';
    
    @override
    State<SettingsIndexerDetails> createState() => _State();
}

class _State extends State<SettingsIndexerDetails> {
    final _scaffoldKey = GlobalKey<ScaffoldState>();

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: LSAppBar(title: 'Indexer Details'),
        body: _body,
    );

    Widget get _body => LSListView(
        children: <Widget>[],
    );
}
