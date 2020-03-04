import 'package:flutter/material.dart';
import 'package:lunasea/widgets/ui.dart';

class SearchSearch extends StatefulWidget {
    static const ROUTE_NAME = '/search/search';

    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<SearchSearch> {
    final _scaffoldKey = GlobalKey<ScaffoldState>();

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            key: _scaffoldKey,
            appBar: _appBar,
            body: _body,
        );
    }

    Widget get _appBar => LSAppBar(title: 'Search');

    Widget get _body => LSGenericMessage(text: 'Coming Soon');
}