import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';
import 'package:tautulli/tautulli.dart';

class TautulliLibrariesDetailsInformation extends StatefulWidget {
    final int sectionId;

    TautulliLibrariesDetailsInformation({
        Key key,
        @required this.sectionId,
    }) : super(key: key);

    @override
    State<TautulliLibrariesDetailsInformation> createState() => _State();
}

class _State extends State<TautulliLibrariesDetailsInformation> with AutomaticKeepAliveClientMixin {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final GlobalKey<RefreshIndicatorState> _refreshKey = GlobalKey<RefreshIndicatorState>();
    bool _initialLoad = false;

    @override
    bool get wantKeepAlive => true;

    Future<void> _refresh() async {
        TautulliLocalState _state = Provider.of<TautulliLocalState>(context, listen: false);
        _state.resetLibrariesTable(context);
        _state.fetchLibraryWatchTimeStats(context, widget.sectionId);
        setState(() => _initialLoad = true);
        await Future.wait([
            _state.librariesTable,
            _state.libraryWatchTimeStats[widget.sectionId],
        ]);
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
            body: _initialLoad ? _body : LSLoader(),
        );
    }

    Widget get _body => LSRefreshIndicator(
        refreshKey: _refreshKey,
        onRefresh: _refresh,
        child: FutureBuilder(
            future: Future.wait([
                Provider.of<TautulliLocalState>(context).librariesTable,
                Provider.of<TautulliLocalState>(context).libraryWatchTimeStats[widget.sectionId],
            ]),
            builder: (context, AsyncSnapshot<List<Object>> snapshot) {
                if(snapshot.hasError) return LSErrorMessage(onTapHandler: () async => _refreshKey.currentState.show());
                if(snapshot.hasData) {
                    TautulliTableLibrary library = (snapshot.data[0] as TautulliLibrariesTable).libraries.firstWhere(
                        (element) => element.sectionId == widget.sectionId,
                        orElse: () => null,
                    );
                    return library == null
                        ? _unknown
                        : _list(
                            library: library,
                            watchTimeStats: (snapshot.data[1] as List<TautulliLibraryWatchTimeStats>),
                        );
                }
                return LSLoader();
            },
        ),
    );

    Widget _list({
        @required TautulliTableLibrary library,
        @required List<TautulliLibraryWatchTimeStats> watchTimeStats,
    }) {
        return LSListView(
            children: [
                TautulliLibrariesDetailsInformationDetails(library: library),
                TautulliLibrariesDetailsInformationGlobalStats(watchtime: watchTimeStats),
            ],
        );
    }

    Widget get _unknown => LSGenericMessage(text: 'Library Not Found');
}
