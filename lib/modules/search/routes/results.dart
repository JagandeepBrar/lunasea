import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/widgets/ui.dart';
import '../../search.dart';

class SearchResults extends StatefulWidget {
    static const ROUTE_NAME = '/search/results';

    @override
    State<SearchResults> createState() =>  _State();
}

class _State extends State<SearchResults> {
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    final _refreshKey = GlobalKey<RefreshIndicatorState>();
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
    }

    Widget get _appBar => LSAppBar(
        title: Provider.of<SearchModel>(context, listen: false)?.searchTitle ?? 'Results',
        actions: <Widget>[
            LSIconButton(
                icon: Icons.search,
                onPressed: _enterSearch,
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

    Widget get _list => _results.length > 0
        ? LSListViewBuilder(
            itemCount: _results.length,
            itemBuilder: (context, index) => SearchResultTile(
                result: _results[index],
            ),
        )
        : LSGenericMessage(
            text: 'No Results Found',
            showButton: true,
            buttonText: 'Try Again',
            onTapHandler: () => _refresh,
        );

    Future<void> _enterSearch() async {
        final model = Provider.of<SearchModel>(context, listen: false);
        model.searchQuery = '';
        await Navigator.of(context).pushNamed(SearchSearch.ROUTE_NAME);
    }
}
