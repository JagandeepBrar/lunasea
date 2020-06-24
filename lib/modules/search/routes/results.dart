import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/search.dart';

class SearchResults extends StatefulWidget {
    static const ROUTE_NAME = '/search/results';

    @override
    State<SearchResults> createState() =>  _State();
}

class _State extends State<SearchResults> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final GlobalKey<RefreshIndicatorState> _refreshKey = GlobalKey<RefreshIndicatorState>();
    final ScrollController _scrollController = ScrollController();

    Future<List<NewznabResultData>> _future;
    List<NewznabResultData> _results = [];

    @override
    void initState() {
        super.initState();
        _refresh();
    }

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
        body: _body,
    );

    Future<void> _refresh() async {
        final model = Provider.of<SearchModel>(context, listen: false);
        if(mounted) setState(() => { _future = NewznabAPI.from(model?.indexer).getResults(
            categoryId: model?.searchCategoryID,
            query: '',
        )});
        Future.microtask(() => Provider.of<SearchModel>(context, listen: false)?.searchResultsFilter = '');
    }

    Widget get _appBar => LSAppBar(
        title: Provider.of<SearchModel>(context, listen: false)?.searchTitle ?? 'Results',
        actions: <Widget>[
            LSIconButton(
                icon: Icons.search,
                onPressed: () async => _enterSearch(),
            ),
        ],
    );

    Widget get _body => LSRefreshIndicator(
        refreshKey: _refreshKey,
        onRefresh: _refresh,
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
                    default: return LSLoading();
                }
            },
        ),
    );

    Widget get _list => _results.length == 0
        ? LSGenericMessage(
            text: 'No Results Found',
            showButton: true,
            buttonText: 'Refresh',
            onTapHandler: () => _refresh(),
        )
        : Consumer<SearchModel>(
            builder: (context, model, widget) {
                List<NewznabResultData> _filtered = _sort(model, _filter(model.searchResultsFilter));
                return _listBody(_filtered);
            },
        );

    Widget _listBody(List filtered) {
        List<Widget> _children = filtered.length == 0
            ? [LSGenericMessage(text: 'No Results Found')]
            : List.generate(
                filtered.length,
                (index) => SearchResultTile(data: filtered[index]),
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

    Widget get _searchSortBar => LSContainerRow(
        padding: EdgeInsets.zero,
        backgroundColor: Theme.of(context).primaryColor,
        children: <Widget>[
            SearchResultsSearchBar(),
            SearchResultsSortButton(controller: _scrollController),
        ],
    );

    Future<void> _enterSearch() async {
        final model = Provider.of<SearchModel>(context, listen: false);
        model.searchQuery = '';
        await Navigator.of(context).pushNamed(SearchSearch.ROUTE_NAME);
    }

    List<NewznabResultData> _filter(String filter) => _results.where(
        (entry) => filter == null || filter == ''
            ? entry != null
            : entry.title.toLowerCase().contains(filter.toLowerCase())
    ).toList();

    List<NewznabResultData> _sort(SearchModel model, List<NewznabResultData> data) {
        if(data != null && data.length != 0) return model.sortResultsSorting.sort(data, model.sortResultsAscending);
        return data;
    }
}
