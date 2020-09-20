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
        TautulliState _global = Provider.of<TautulliState>(context, listen: false);
        TautulliLocalState _local = Provider.of<TautulliLocalState>(context, listen: false);
        // Initial load or refresh of the user profile data
        _local.setUserProfile(
            widget.user.userId,
            _global.api.users.getUser(userId: widget.user.userId),
        );
        // Initial load or refresh of the user watch stats
        _local.setUserWatchStats(
            widget.user.userId,
            _global.api.users.getUserWatchTimeStats(userId: widget.user.userId, queryDays: [1, 7, 30, 0]),
        );
        // Initial load or refresh of the user player stats
        _local.setUserPlayerStats(
            widget.user.userId,
            _global.api.users.getUserPlayerStats(userId: widget.user.userId),
        );
        setState(() => _initialLoad = true);
        // This await keeps the refresh indicator showing until the data is loaded
        await Future.wait([
            _local.userProfile[widget.user.userId],
            _local.userWatchStats[widget.user.userId],
            _local.userPlayerStats[widget.user.userId],
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
                    Provider.of<TautulliLocalState>(context).userProfile[widget.user.userId],
                    Provider.of<TautulliLocalState>(context).userWatchStats[widget.user.userId],
                    Provider.of<TautulliLocalState>(context).userPlayerStats[widget.user.userId],
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
            _profile(user),
            _globalStats(watchtime),
            if(player.length > 0) ..._playerStats(player),
        ],
    );

    Widget _profile(TautulliUser user) => LSTableBlock(
        title: 'Profile',
        children: [
            LSTableContent(title: 'email', body: user.email),
            LSTableContent(title: 'last seen', body: widget.user.lastSeen != null
                ? DateTime.now().lsDateTime_ageString(widget.user.lastSeen)
                : 'Never',
            ),
            LSTableContent(title: '', body: ''),
            LSTableContent(title: 'title', body: widget.user.lastPlayed ?? 'None'),
            LSTableContent(title: 'platform', body: widget.user.platform ?? 'None'),
            LSTableContent(title: 'player', body: widget.user.player ?? 'None'),
            LSTableContent(title: 'location', body: widget.user.ipAddress ?? 'None'),
        ],
    );

    Widget _globalStats(List<TautulliUserWatchTimeStats> watchtime) => LSTableBlock(
        title: 'Global Stats',
        children: List.generate(
            watchtime.length,
            (index) => LSTableContent(
                title: _globalStatsTitle(watchtime[index].queryDays),
                body: _globalStatsContent(watchtime[index].totalPlays, watchtime[index].totalTime),
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
                            LSTableContent(title: 'player', body: player[index].playerName),
                            LSTableContent(title: 'platform', body: player[index].platform),
                            LSTableContent(title: 'plays', body: player[index].totalPlays == 1 ? '1 Play' : '${player[index].totalPlays} Plays'),
                        ],
                    ),
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                ),
            ),
        ),
    ];
}
