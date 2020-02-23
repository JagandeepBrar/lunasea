import 'package:flutter/material.dart';
import 'package:lunasea/widgets/ui.dart';

class Search extends StatefulWidget {
    static const ROUTE_NAME = '/search';

    @override
    State<Search> createState() =>  _State();
}

class _State extends State<Search> {
    @override
    Widget build(BuildContext context) => Scaffold(
        appBar: _appBar,
        drawer: _drawer,
        body: LSGenericMessage(text: 'Coming Soon'),
    );

    Widget get _appBar => LSAppBar(title: 'Search');

    Widget get _drawer => LSDrawer(page: 'search');
}
