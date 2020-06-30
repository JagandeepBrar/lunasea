import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrSearchResultsArguments {
    final int episodeID;
    final String title;

    SonarrSearchResultsArguments({
        @required this.episodeID,
        @required this.title,
    });
}

class SonarrSearchResults extends StatefulWidget {
    static const ROUTE_NAME = '/sonarr/search/results';

    @override
    State<SonarrSearchResults> createState() => _State();
}

class _State extends State<SonarrSearchResults> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final GlobalKey<RefreshIndicatorState> _refreshKey = GlobalKey<RefreshIndicatorState>();
    final ScrollController _scrollController = ScrollController();

    SonarrSearchResultsArguments _arguments;
    Future<List<SonarrReleaseData>> _future;
    List<SonarrReleaseData> _results;

    @override
    void initState() {
        super.initState();
        SchedulerBinding.instance.scheduleFrameCallback((_) {
            setState(() => _arguments = ModalRoute.of(context).settings.arguments);
            _refresh();
        });
    }

    Future<void> _refresh() async {
        if(mounted) setState(() => _results = []);
        final _api = SonarrAPI.from(Database.currentProfileObject);
        setState(() => { _future = _api.getReleases(_arguments.episodeID) });
        //Clear the search filter using a microtask
        Future.microtask(() => Provider.of<SonarrModel>(context, listen: false)?.searchReleasesFilter = '');
    }

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
        body: _body,
    );

    Widget get _appBar => _arguments == null
        ? null
        : LSAppBar(title: _arguments.title);

    Widget get _body => _arguments == null
        ? null
        : LSRefreshIndicator(
            refreshKey: _refreshKey,
            onRefresh: () => _refresh(),
            child: FutureBuilder(
                future: _future,
                builder: (context, snapshot) {
                    switch(snapshot.connectionState) {
                        case ConnectionState.done: {
                            if(snapshot.hasError || snapshot.data == null) return LSErrorMessage(onTapHandler: () => _refresh());
                            _results = snapshot.data;
                            return _list;
                        }
                        case ConnectionState.none:
                        case ConnectionState.waiting:
                        case ConnectionState.active:
                        default: return LSTypewriterMessage(text: 'Searching...');
                    }
                },
            ),
        );

    Widget get _searchSortBar => LSContainerRow(
        padding: EdgeInsets.zero,
        backgroundColor: Theme.of(context).primaryColor,
        children: <Widget>[
            SonarrReleasesSearchBar(),
            SonarrReleasesHideButton(controller: _scrollController),
            SonarrReleasesSortButton(controller: _scrollController),
        ],
    );

    Widget get _list => _results.length == 0
        ? LSGenericMessage(
            text: 'No Results Found',
            showButton: true,
            buttonText: 'Refresh',
            onTapHandler: () => _refresh(),
        )
        : Consumer<SonarrModel>(
            builder: (context, model, widget) {
                List<SonarrReleaseData> _filtered = _sort(model, _filter(model.searchReleasesFilter));
                _filtered = model.hideRejectedReleases ? _hide(_filtered) : _filtered;
                return _listBody(_filtered);
            },
        );

    Widget _listBody(List filtered) {
        List<Widget> _children = filtered.length == 0
            ? [LSGenericMessage(text: 'No Results Found')]
            : List.generate(
                filtered.length,
                (index) => SonarrSearchResultTile(data: filtered[index]),
            );
        return LSListViewStickyHeader(
            controller: _scrollController,
            slivers: [
                LSStickyHeader(
                    header: _searchSortBar,
                    children: _children,
                )
            ],
        );
    }

    List<SonarrReleaseData> _filter(String filter) => _results.where(
        (entry) => filter == null || filter == ''
            ? entry != null
            : entry.title.toLowerCase().contains(filter.toLowerCase())
    ).toList();

    List<SonarrReleaseData> _sort(SonarrModel model, List<SonarrReleaseData> data) {
        if(data != null && data.length != 0) return model.sortReleasesType.sort(data, model.sortReleasesAscending);
        return data;
    }

    List<SonarrReleaseData> _hide(List<SonarrReleaseData> data) => data == null || data.length == 0
        ? data
        : data.where((entry) => entry.approved).toList();
}
