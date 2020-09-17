import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class TautulliMoreRoute extends StatefulWidget {
    TautulliMoreRoute({
        Key key,
    }): super(key: key);

    @override
    State<TautulliMoreRoute> createState() => _State();
}

class _State extends State<TautulliMoreRoute> with AutomaticKeepAliveClientMixin {
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

    Widget get _body => LSListView(
        children: [
            TautulliMoreCheckForUpdatesTile(),
            TautulliMoreGraphsTile(),
            TautulliMoreLibrariesTile(),
            TautulliMoreLogsTile(),
            TautulliMoreRecentlyAddedTile(),
            TautulliMoreSearchTile(),
            TautulliMoreStatisticsTile(),
            TautulliMoreSyncedItemsTile(),
        ],
    );
}
