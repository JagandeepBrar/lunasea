import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';
import 'package:tautulli/tautulli.dart';

class TautulliLibrariesDetailsUserStats extends StatefulWidget {
    final int sectionId;

    TautulliLibrariesDetailsUserStats({
        Key key,
        @required this.sectionId,
    }) : super(key: key);

    @override
    State<TautulliLibrariesDetailsUserStats> createState() => _State();
}

class _State extends State<TautulliLibrariesDetailsUserStats> with AutomaticKeepAliveClientMixin {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final GlobalKey<RefreshIndicatorState> _refreshKey = GlobalKey<RefreshIndicatorState>();

    @override
    bool get wantKeepAlive => true;

    Future<void> _refresh() async {
        TautulliLocalState _state = Provider.of<TautulliLocalState>(context, listen: false);
        _state.fetchLibraryUserStats(context, widget.sectionId);
        await _state.libraryUserStats[widget.sectionId];
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
        child: FutureBuilder(
            future: Provider.of<TautulliLocalState>(context).libraryUserStats[widget.sectionId],
            builder: (context, AsyncSnapshot<List<TautulliLibraryUserStats>> snapshot) {
                if(snapshot.hasError) return LSErrorMessage(onTapHandler: () async => _refreshKey.currentState.show());
                if(snapshot.hasData) return snapshot.data.length == 0 ? _noStatsFound : _list(userStats: snapshot.data);
                return LSLoader();
            },
        ),
    );

    Widget _list({ @required List<TautulliLibraryUserStats> userStats }) {
        return LSListView(
            children: List<Widget>.generate(
                userStats.length,
                (index) => TautulliLibrariesDetailsUserStatsTile(user: userStats[index]),
            ),
        );
    }

    Widget get _noStatsFound => LSGenericMessage(text: 'No User Stats Found');
}
