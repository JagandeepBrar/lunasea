import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/search.dart';

class SearchSearch extends StatefulWidget {
    static const ROUTE_NAME = '/search/search';

    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<SearchSearch> {
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    final _refreshKey = GlobalKey<RefreshIndicatorState>();
    final _scrollController = ScrollController();
    Future<List<NewznabResultData>> _future;
    List<NewznabResultData> _results = [];

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            key: _scaffoldKey,
            appBar: _appBar,
            body: _body,
        );
    }

    Future<void> _refresh() async {
        final model = Provider.of<SearchModel>(context, listen: false);
        if(mounted) setState(() {
            _future = NewznabAPI.from(model?.indexer).getResults(
                categoryId: model?.searchCategoryID,
                query: model?.searchQuery,
            );
        });
    }

    Widget get _appBar => LSAppBar(title: 'Search: ${Provider.of<SearchModel>(context, listen: false)?.searchTitle ?? 'Unknown'}');

    Widget get _body => LSRefreshIndicator(
        refreshKey: _refreshKey,
        onRefresh: _refresh,
        child: Consumer<SearchModel>(
            builder: (context, model, widget) => FutureBuilder(
                future: _future,
                builder: (context, snapshot) {
                    List<Widget> _data;
                    switch(snapshot.connectionState) {
                        case ConnectionState.done: {
                            if(snapshot.hasError || snapshot.data == null) {
                                _data = _error;
                            } else {
                                _results = snapshot.data;
                                _data = _assembleResults(model);
                            }
                            break;
                        }
                        case ConnectionState.none: _data = []; break;
                        case ConnectionState.waiting:
                        case ConnectionState.active:
                        default: _data = _loading; break;
                        
                    }
                    return _list(_data);
                },
            ),
        ),
    );

    Widget _list(List<Widget> data) => LSListViewStickyHeader(
        controller: _scrollController,
        slivers: <Widget>[
            LSStickyHeader(
                header: _searchBar,
                children: data,
            ),
        ],
    );

    Widget get _searchBar => LSContainerRow(
        padding: EdgeInsets.zero,
        backgroundColor: Theme.of(context).primaryColor,
        children: [
            SearchSearchBar(callback: _refresh),
            SearchResultsSortButton(controller: _scrollController),
        ],
    );

    List<Widget> get _loading => [LSTypewriterMessage(text: 'Searching...')];

    List<Widget> get _error => [LSErrorMessage(onTapHandler: () => _refresh(), hideButton: true)];

    List<Widget> _assembleResults(SearchModel model) {
        if(_results.length <= 0) {
            return [LSGenericMessage(text: 'No Results Found')];
        }
        List<NewznabResultData> _sorted = _sort(model, _results);
        return List.generate(
            _sorted.length,
            (index) => SearchResultTile(
                data: _sorted[index],
            ),
        );
    }

    List<NewznabResultData> _sort(SearchModel model, List<NewznabResultData> data) {
        if(data != null && data.length != 0) return model.sortResultsSorting.sort(data, model.sortResultsAscending);
        return data;
    }
}