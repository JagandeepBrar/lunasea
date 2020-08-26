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

    // Tracks the initial load to ensure the futures have been initialized
    bool _initialLoad = false;

    @override
    void initState() {
        super.initState();
        SchedulerBinding.instance.scheduleFrameCallback((_) => _refresh());
    }

    Future<void> _refresh() async {
        TautulliState _state = Provider.of<TautulliState>(context, listen: false);
        // Initial load or refresh of the user profile data
        _state.setUserProfile(
            widget.user.userId,
            _state.api.users.getUser(userId: widget.user.userId),
        );
        // Initial load or refresh of the user watch stats
        _state.setUserWatchStats(
            widget.user.userId,
            _state.api.users.getUserWatchTimeStats(userId: widget.user.userId, queryDays: [1, 7, 30, 0]),
        );
        // Initial load or refresh of the user player stats
        _state.setUserPlayerStats(
            widget.user.userId,
            _state.api.users.getUserPlayerStats(userId: widget.user.userId),
        );
        setState(() => _initialLoad = true);
        // This await keeps the refresh indicator showing until the data is loaded
        await Future.wait([
            _state.userProfile[widget.user.userId],
            _state.userWatchStats[widget.user.userId],
            _state.userPlayerStats[widget.user.userId],
        ]);
    }

    @override
    Widget build(BuildContext context) {
        super.build(context);
        return Scaffold(
            key: _scaffoldKey,
            body: _body,
        );
    }

    Widget get _body => _initialLoad
        ? LSRefreshIndicator(
            refreshKey: _refreshKey,
            onRefresh: _refresh,
            child: FutureBuilder(
                future: Future.wait([
                    Provider.of<TautulliState>(context).userProfile[widget.user.userId],
                    Provider.of<TautulliState>(context).userWatchStats[widget.user.userId],
                    Provider.of<TautulliState>(context).userPlayerStats[widget.user.userId],
                ]),
                builder: (context, AsyncSnapshot<List<Object>> snapshot) {
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
                        return LSErrorMessage(onTapHandler: () async => _refreshKey.currentState.show());
                    }
                    if(snapshot.hasData) return _list(
                        user: snapshot.data[0],
                        watchtime: snapshot.data[1],
                        player: snapshot.data[2],
                    );
                    return LSLoader();
                },
            ),
        )
        : LSLoader();

    Widget _list({
        @required TautulliUser user,
        @required List<TautulliUserWatchTimeStats> watchtime,
        @required List<TautulliUserPlayerStats> player,
    }) => LSListView(
        children: [
            ..._profile(user),
            ..._globalStats(watchtime),
            ..._playerStats(player),
        ],
    );

    List<Widget> _profile(TautulliUser user) => _block(
        title: 'Profile',
        children: [
            _content('email', user.email),
            _content('last seen', widget.user.lastSeen != null
                ? DateTime.now().lsDateTime_ageString(widget.user.lastSeen)
                : 'Never',
            ),
            _content('', ''),
            _content('title', widget.user.lastPlayed ?? 'None'),
            _content('platform', widget.user.platform ?? 'None'),
            _content('player', widget.user.player ?? 'None'),
            _content('location', widget.user.ipAddress ?? 'None'),
        ],
    );

    List<Widget> _globalStats(List<TautulliUserWatchTimeStats> watchtime) => _block(
        title: 'Global Stats',
        children: List.generate(
            watchtime.length,
            (index) => _content(
                _globalStatsTitle(watchtime[index].queryDays),
                _globalStatsContent(watchtime[index].totalPlays, watchtime[index].totalTime),
            ),
        ),
    );

    String _globalStatsTitle(int days) {
        if(days == 0) return 'All Time';
        if(days == 1) return '24 Hours';
        return '$days Days';
    }

    String _globalStatsContent(int plays, Duration duration) {
        String _plays = plays == 1 ? '1 Play': '$plays Plays';
        return '$_plays\n${duration.lsDuration_fullTimestamp()}';
    }

    List<Widget> _playerStats(List<TautulliUserPlayerStats> player) => [
        LSHeader(text: 'Player Stats'),
        ...List.generate(
            player.length,
            (index) => LSCard(
                child: Padding(
                    child: Column(
                        children: [
                            _content('player', player[index].playerName),
                            _content('platform', player[index].platform),
                            _content('plays', player[index].totalPlays == 1 ? '1 Play' : '${player[index].totalPlays} Plays'),
                        ],
                    ),
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                ),
            ),
        ),
    ];

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
