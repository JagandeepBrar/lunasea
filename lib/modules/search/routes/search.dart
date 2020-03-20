import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/widgets/ui.dart';
import '../../search.dart';

class SearchSearch extends StatefulWidget {
    static const ROUTE_NAME = '/search/search';

    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<SearchSearch> {
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    final _refreshKey = GlobalKey<RefreshIndicatorState>();
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
        child: FutureBuilder(
            future: _future,
            builder: (context, snapshot) {
                List _data;
                switch(snapshot.connectionState) {
                    case ConnectionState.done: {
                        if(snapshot.hasError || snapshot.data == null) {
                            _data = _error;
                        } else {
                            _results = snapshot.data;
                            _data = _assembleResults;
                        }
                        break;
                    }
                    case ConnectionState.none: _data = []; break;
                    case ConnectionState.waiting:
                    case ConnectionState.active:
                    default: _data = _loading; break;
                    
                }
                return LSListView(
                    children: <Widget>[
                        SearchSearchBar(callback: _refresh),
                        ..._data,
                    ],
                    padBottom: true,
                );
            },
        ),
    );

    List get _loading => [
        LSDivider(),
        LSLoading(),
    ];

    List get _error => [
        LSDivider(),
        LSErrorMessage(
            onTapHandler: _refresh,
        ),
    ];

    List get _assembleResults => _results.length > 0
        ? [
            LSDivider(),
            ...List.generate(
                _results.length,
                (index) => SearchResultTile(
                    result: _results[index],
                ),
            ),
        ]
        : [
            LSDivider(),
            ...List.generate(
                1,
                (index) => LSGenericMessage(
                    text: 'No Results Found',
                    showButton: true,
                    buttonText: 'Try Again',
                    onTapHandler: _refresh,
                ),
            ),
        ];
}