import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';
import 'package:tautulli/tautulli.dart';

class TautulliUsersRoute extends StatefulWidget {
    static const ROUTE_NAME = '/tautulli/users';

    TautulliUsersRoute({
        Key key,
    }): super(key: key);

    @override
    State<TautulliUsersRoute> createState() => _State();
}

class _State extends State<TautulliUsersRoute> with AutomaticKeepAliveClientMixin {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final GlobalKey<RefreshIndicatorState> _refreshKey = GlobalKey<RefreshIndicatorState>();
    
    @override
    bool get wantKeepAlive => true;

    Future<void> _refresh() async {
        TautulliState _state = Provider.of<TautulliState>(context, listen: false);
        _state.resetUsers();
    }

    @override
    Widget build(BuildContext context) {
        super.build(context);
        return Scaffold(
            key: _scaffoldKey,
            body: _body,
        );
    }

    Widget get _body => LSRefreshIndicator(
        refreshKey: _refreshKey,
        onRefresh: _refresh,
        child: Selector<TautulliState, Future<TautulliUsersTable>>(
            selector: (_, state) => state.users,
            builder: (context, users, _) => FutureBuilder(
                future: users,
                builder: (context, snapshot) {
                    if(snapshot.hasError) {
                        if(snapshot.connectionState != ConnectionState.waiting) {
                            Logger.error(
                                'TautulliUsersRoute',
                                '_body',
                                'Unable to fetch Tautulli users',
                                snapshot.error,
                                null,
                                uploadToSentry: !(snapshot.error is DioError),
                            );
                        }
                        return LSErrorMessage(onTapHandler: () async => _refresh());
                    }
                    if(snapshot.hasData) return (snapshot.data as TautulliUsersTable).users.length == 0
                        ? _noUsers()
                        : _list((snapshot.data as TautulliUsersTable));
                    return LSLoader();
                },
            ),
        ),
    );

    Widget _list(TautulliUsersTable users) => LSListViewBuilder(
        itemCount: users.users.length,
        itemBuilder: (context, index) => TautulliUserTile(user: users.users[index]),
    );

    Widget _noUsers() => LSGenericMessage(
        text: 'No Users Found',
        showButton: true,
        buttonText: 'Refresh',
        onTapHandler: () async => _refresh(),
    );
}
