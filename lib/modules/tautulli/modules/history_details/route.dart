import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';
import 'package:tautulli/tautulli.dart';

class TautulliHistoryDetailsRoute extends StatefulWidget {
    final TautulliHistoryRecord history;

    TautulliHistoryDetailsRoute({
        Key key,
        @required this.history,
    }) : super(key: key);

    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<TautulliHistoryDetailsRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
        body: _body,
    );

    Widget get _appBar => LSAppBar(
        title: 'History Details',
        actions: [
            TautulliHistoryDetailsMetadata(),
        ],
    );

    Widget get _body => TautulliHistoryDetailsInformation(history: widget.history);
}