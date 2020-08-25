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
                if(snapshot.hasData) return _list(snapshot.data as TautulliUser);
                return LSLoader();
            },
        ),
    );

    Widget _list(TautulliUser user) => LSListView(
        children: [
            ..._profile(user),
            ..._lastSession(),
        ],
    );

    List<Widget> _profile(TautulliUser user) => _block(
        title: 'Profile',
        children: [
            _content('email', user.email),
            _content('total plays', widget.user.plays.toString()),
            _content('last seen', widget.user.lastSeen != null
                ? DateTime.now().lsDateTime_ageString(widget.user.lastSeen)
                : 'Never',
            ),
            _content('', ''),
            _content('home user', user.isHomeUser ? 'Yes' : 'No'),
            _content('can sync', user.isAllowSync ? 'Yes' : 'No'),
            _content('admin', user.isAdmin ? 'Yes' : 'No'),
        ],
    );

    List<Widget> _lastSession() => _block(
        title: 'Last Session',
        children: [
            _content('location', widget.user.ipAddress ?? 'None'),
            _content('title', widget.user.lastPlayed ?? 'None'),
            _content('platform', widget.user.platform ?? 'None'),
            _content('player', widget.user.player ?? 'None'),
        ],
    );

    List<Widget> _block({
        @required String title,
        @required List<Widget> children,
    }) => [
        LSHeader(text: title),
        LSCard(
            child: Padding(
                child: Column(
                    children: children,
                ),
                padding: EdgeInsets.symmetric(vertical: 8.0),
            ),
        ),
    ];

    Widget _content(String header, String body) => Padding(
        child: Row(
            children: [
                Expanded(
                    child: Text(
                        header.toUpperCase(),
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            color: Colors.white70,
                        ),
                    ),
                    flex: 2,
                ),
                Container(width: 16.0, height: 0.0),
                Expanded(
                    child: Text(
                        body,
                        textAlign: TextAlign.start,
                        style: TextStyle(),
                    ),
                    flex: 5,
                ),
            ],
            crossAxisAlignment: CrossAxisAlignment.start,
        ),
        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
    );
}
