import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/lidarr.dart';

class LidarrSearchResultsArguments {
    final int albumID;
    final String title;

    LidarrSearchResultsArguments({
        @required this.albumID,
        @required this.title,
    });
}

class LidarrSearchResults extends StatefulWidget {
    static const ROUTE_NAME = '/lidarr/search/results';

    @override
    State<LidarrSearchResults> createState() => _State();
}

class _State extends State<LidarrSearchResults> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final GlobalKey<RefreshIndicatorState> _refreshKey = GlobalKey<RefreshIndicatorState>();
    final ScrollController _scrollController = ScrollController();

    LidarrSearchResultsArguments _arguments;
    Future<List<LidarrReleaseData>> _future;
    List<LidarrReleaseData> _results;

    @override
    void initState() {
        super.initState();
        SchedulerBinding.instance.scheduleFrameCallback((_) {
            _arguments = ModalRoute.of(context).settings.arguments;
            _refresh();
        });
    }

    Future<void> _refresh() async {
        if(mounted) setState(() => _results = []);
        final _api = LidarrAPI.from(Database.currentProfileObject);
        setState(() => { _future = _api.getReleases(_arguments.albumID) });
        //Clear the search filter using a microtask
        Future.microtask(() => Provider.of<LidarrModel>(context, listen: false)?.searchReleasesFilter = '');
    }

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        body: _body,
        appBar: _appBar,
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
            LidarrReleasesSearchBar(),
            LidarrReleasesHideButton(controller: _scrollController),
            LidarrReleasesSortButton(controller: _scrollController),
        ],
    );

    Widget get _list => _results.length == 0
        ? LSGenericMessage(
            text: 'No Results Found',
            showButton: true,
            buttonText: 'Refresh',
            onTapHandler: () => _refresh(),
        )
        : Consumer<LidarrModel>(
            builder: (context, model, widget) {
                List<LidarrReleaseData> _filtered = _sort(model, _filter(model.searchReleasesFilter));
                _filtered = model.hideRejectedReleases ? _hide(_filtered) : _filtered;
                return _listBody(_filtered);
            },
        );

    Widget _listBody(List filtered) {
        List<Widget> _children = filtered.length == 0
            ? [LSGenericMessage(text: 'No Results Found')]
            : List.generate(
                filtered.length,
                (index) => LidarrSearchResultTile(data: filtered[index]),
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

    List<LidarrReleaseData> _filter(String filter) => _results.where(
        (entry) => filter == null || filter == ''
            ? entry != null
            : entry.title.toLowerCase().contains(filter.toLowerCase())
    ).toList();

    List<LidarrReleaseData> _sort(LidarrModel model, List<LidarrReleaseData> data) {
        if(data != null && data.length != 0) return model.sortReleasesType.sort(data, model.sortReleasesAscending);
        return data;
    }

    List<LidarrReleaseData> _hide(List<LidarrReleaseData> data) => data == null || data.length == 0
        ? data
        : data.where((entry) => entry.approved).toList();
}
