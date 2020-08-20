import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class TautulliHistoryRoute extends StatefulWidget {
    static const ROUTE_NAME = '/tautulli/history';

    TautulliHistoryRoute({
        Key key,
    }): super(key: key);

    @override
    State<TautulliHistoryRoute> createState() => _State();
}

class _State extends State<TautulliHistoryRoute> with AutomaticKeepAliveClientMixin {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
   
    @override
    bool get wantKeepAlive => true;

    @override
    Widget build(BuildContext context) {
        super.build(context);
        return Scaffold(
            key: _scaffoldKey,
            body: _body,
        );
    }

    Widget get _body => LSGenericMessage(text: 'Coming Soon');
}
