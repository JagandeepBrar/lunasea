import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/widgets/pages/search/results.dart';
import 'package:lunasea/widgets/ui.dart';

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
        SchedulerBinding.instance.addPostFrameCallback((_) => _refreshKey?.currentState?.show());
    }

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
        body: _body,
    );

    Future<void> _refresh() async {
        final model = Provider.of<SearchModel>(context, listen: false);
        setState(() => { _future = NewznabAPI.from(model?.indexer).getResults(
            categoryId: model?.searchCategoryID,
            query: model?.searchQuery,
        )});
        //Keep the indicator showing by waiting for the future
        await _future.catchError((error) => {});
    }

    Widget get _appBar => LSAppBar(title: Provider.of<SearchModel>(context, listen: false)?.searchTitle ?? 'Results');

    Widget get _body => LSRefreshIndicator(
        refreshKey: _refreshKey,
        onRefresh: _refresh,
        child: FutureBuilder(
            future: _future,
            builder: (context, snapshot) {
                switch(snapshot.connectionState) {
                    case ConnectionState.done: {
                        if(snapshot.hasError || snapshot.data == null) return LSErrorMessage(onTapHandler: () => _refreshKey?.currentState?.show());
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
            itemBuilder: (context, index) => LSSearchResultTile(
                result: _results[index],
            ),
        )
        : LSGenericMessage(
            text: 'No Results Found',
            showButton: true,
            buttonText: 'Try Again',
            onTapHandler: () => _refreshKey?.currentState?.show(),
        );
}
