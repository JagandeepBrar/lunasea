import 'package:flutter/material.dart';
import 'package:lunasea/widgets/ui.dart';

class SettingsIndexersAdd extends StatefulWidget {
    static const ROUTE_NAME = '/settings/indexers/add';
    
    @override
    State<SettingsIndexersAdd> createState() {
        return _State();
    }
}

class _State extends State<SettingsIndexersAdd> {
    final _scaffoldKey = GlobalKey<ScaffoldState>();

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            key: _scaffoldKey,
            appBar: LSAppBar(title: 'Add Indexer'),
            body: _body,
        );
    }

    Widget get _body => LSButton(text: 'pop', onTap: () async {
        Navigator.of(context).pop(['indexer_added']);
    });
}
