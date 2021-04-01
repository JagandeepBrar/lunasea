import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';
import 'package:tautulli/tautulli.dart';

class TautulliUsersRoute extends StatefulWidget {
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
        context.read<TautulliState>().resetUsers();
        await context.read<TautulliState>().users;
    }

    @override
    void initState() {
        super.initState();
        SchedulerBinding.instance.scheduleFrameCallback((_) => _refresh());
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
                builder: (context, AsyncSnapshot<TautulliUsersTable> snapshot) {
                    if(snapshot.hasError) {
                        if(snapshot.connectionState != ConnectionState.waiting) {
                            LunaLogger().error('Unable to fetch Tautulli users', snapshot.error, snapshot.stackTrace);
                        }
                        return LSErrorMessage(onTapHandler: () async => _refreshKey.currentState.show());
                    }
                    if(snapshot.hasData) return snapshot.data.users.length == 0
                        ? _noUsers()
                        : _users(snapshot.data);
                    return LSLoader();
                },
            ),
        ),
    );

    Widget _users(TautulliUsersTable users) => LSListViewBuilder(
            itemCount: users.users.length,
            itemBuilder: (context, index) => TautulliUserTile(user: users.users[index]),
        );

    Widget _noUsers() => LSGenericMessage(
        text: 'No Users Found',
        showButton: true,
        buttonText: 'Refresh',
        onTapHandler: () async => _refreshKey.currentState.show(),
    );
}
