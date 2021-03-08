import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/search.dart';

class SearchResults extends StatefulWidget {
    static const ROUTE_NAME = '/search/results';

    @override
    State<SearchResults> createState() =>  _State();
}

class _State extends State<SearchResults> with LunaLoadCallbackMixin {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final GlobalKey<RefreshIndicatorState> _refreshKey = GlobalKey<RefreshIndicatorState>();
    final ScrollController _scrollController = ScrollController();

    Future<List<NewznabResultData>> _future;
    List<NewznabResultData> _results = [];

    @override
    Future<void> loadCallback() async {
        final model = Provider.of<SearchState>(context, listen: false);
        if(mounted) setState(() => { _future = NewznabAPI.from(model?.indexer).getResults(
            categoryId: model?.searchCategoryID,
            query: '',
        )});
        Future.microtask(() => Provider.of<SearchState>(context, listen: false)?.searchResultsFilter = '');
    }

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
        body: _body,
    );

    Widget get _appBar => LunaAppBar(
        title: Provider.of<SearchState>(context, listen: false)?.searchTitle ?? 'Results',
        actions: <Widget>[
            LSIconButton(
                icon: Icons.search,
                onPressed: () async => _enterSearch(),
            ),
        ],
    );

    Widget get _body => LSRefreshIndicator(
        refreshKey: _refreshKey,
        onRefresh: loadCallback,
        child: FutureBuilder(
            future: _future,
            builder: (context, snapshot) {
                switch(snapshot.connectionState) {
                    case ConnectionState.done: {
                        if(snapshot.hasError || snapshot.data == null) {
                            LunaLogger().error('Unable to fetch results', snapshot.error, snapshot.stackTrace);
                            return LSErrorMessage(onTapHandler: loadCallback);
                        }
                        _results = snapshot.data;
                        return _list;
                    }
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                    case ConnectionState.active:
                    default: return LSLoader();
                }
            },
        ),
    );

    Widget get _list => _results.length == 0
        ? LSGenericMessage(
            text: 'No Results Found',
            showButton: true,
            buttonText: 'Refresh',
            onTapHandler: loadCallback,
        )
        : Consumer<SearchState>(
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
                LunaSliverStickyHeader(
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
        final model = Provider.of<SearchState>(context, listen: false);
        model.searchQuery = '';
        await Navigator.of(context).pushNamed(SearchSearch.ROUTE_NAME);
    }

    List<NewznabResultData> _filter(String filter) => _results.where(
        (entry) => filter == null || filter == ''
            ? entry != null
            : entry.title.toLowerCase().contains(filter.toLowerCase())
    ).toList();

    List<NewznabResultData> _sort(SearchState state, List<NewznabResultData> data) {
        if(data != null && data.length != 0) return state.sortResultsSorting.sort(data, state.sortResultsAscending);
        return data;
    }
}
