import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:tautulli/tautulli.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class TautulliUserDetailsProfile extends StatefulWidget {
    final TautulliTableUser user;

    TautulliUserDetailsProfile({
        Key key,
        @required this.user,
    }): super(key: key);

    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<TautulliUserDetailsProfile> with AutomaticKeepAliveClientMixin {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final GlobalKey<RefreshIndicatorState> _refreshKey = GlobalKey<RefreshIndicatorState>();
    @override
    bool get wantKeepAlive => true;

    @override
    void initState() {
        super.initState();
        SchedulerBinding.instance.scheduleFrameCallback((_) => _refresh());
    }

    Future<void> _refresh() async {
        TautulliState _state = Provider.of<TautulliState>(context, listen: false);
        _state.setUserProfile(
            widget.user.userId,
            _state.api.users.getUser(userId: widget.user.userId),
        );
        await _state.userProfile[widget.user.userId];
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
        child: FutureBuilder(
            future: Provider.of<TautulliState>(context).userProfile[widget.user.userId],
            builder: (context, snapshot) {
                if(snapshot.hasError) {
                    if(snapshot.connectionState != ConnectionState.waiting) {
                        Logger.error(
                            'TautulliUserDetailsProfile',
                            '_body',
                            'Unable to fetch Tautulli user: ${widget.user.userId}',
                            snapshot.error,
                            null,
                            uploadToSentry: !(snapshot.error is DioError),
                        );
                    }
                    return LSErrorMessage(onTapHandler: () async => _refresh());
                }
                if(snapshot.hasData) return _profile(snapshot.data as TautulliUser);
                return LSLoader();
            },
        ),
    );

    Widget _profile(TautulliUser user) => LSListView(
        children: [
            Text(user.friendlyName),
        ],
    );
}
