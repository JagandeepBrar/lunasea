import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/widgets/pages/search/search.dart';
import 'package:lunasea/widgets/ui.dart';

class Search extends StatefulWidget {
    static const ROUTE_NAME = '/search';

    @override
    State<Search> createState() =>  _State();
}

class _State extends State<Search> {
    final _scaffoldKey = GlobalKey<ScaffoldState>();

    @override
    Widget build(BuildContext context) => ValueListenableBuilder(
        valueListenable: Database.indexersBox.listenable(),
        builder: (context, indexerBox, widget) => Scaffold(
            key: _scaffoldKey,
            appBar: _appBar,
            drawer: _drawer,
            body: _body,
        ),
    );

    Widget get _appBar => LSAppBar(title: 'Search');

    Widget get _drawer => LSDrawer(page: 'search');

    Widget get _body => LSListViewBuilder(
        itemCount: Database.indexersBox.length,
        itemBuilder: (context, index) => LSSearchIndexerTile(
            indexer: Database.indexersBox.getAt(index),
            index: index,
        ),
    );
}
