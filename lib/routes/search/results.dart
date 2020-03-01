import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/widgets/ui.dart';

class SearchResultsArguments {
    final int category;
    final String query;
    final IndexerHiveObject indexer;

    SearchResultsArguments({
        @required this.category,
        @required this.query,
        @required this.indexer,
    });
}

class SearchResults extends StatefulWidget {
    static const ROUTE_NAME = '/search/results';

    @override
    State<SearchResults> createState() =>  _State();
}

class _State extends State<SearchResults> {
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    final _refreshKey = GlobalKey<RefreshIndicatorState>();
    Future<List<NewznabResultData>> _future;
    SearchResultsArguments _arguments;

    @override
    void initState() {
        super.initState();
        SchedulerBinding.instance.addPostFrameCallback((_) {
            setState(() => _arguments = ModalRoute.of(context).settings.arguments);
            _refresh();
        });
    }

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
        body: _arguments == null ? null : _body,
    );

    Future<void> _refresh() async {
        setState(() => { _future = NewznabAPI.from(_arguments?.indexer).getResults(
            categoryId: _arguments?.category,
            query: _arguments?.query,
        )});
        await _future;
    }

    Widget get _appBar => LSAppBar(title: 'Results');

    Widget get _body => FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
            switch(snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.done: {
                    if(snapshot.hasError || snapshot.data == null) return _refreshIndicator(LSErrorMessage(onTapHandler: _refresh));
                    return _refreshIndicator(_list(snapshot.data));
                }
                case ConnectionState.waiting:
                case ConnectionState.active:
                default: return _refreshIndicator(LSLoading());
                
            }
        },
    );

    Widget _refreshIndicator(Widget body) => RefreshIndicator(
        key: _refreshKey,
        onRefresh: _refresh,
        backgroundColor: LSColors.secondary,
        child: body,
    );

    Widget _list(List<NewznabResultData> results) => LSListViewBuilder(
        itemCount: results.length,
        itemBuilder: (context, index) => _card(results[index]),
    );

    Widget _card(NewznabResultData data) => LSCardTile(
        title: LSTitle(text: data.title),
        subtitle: LSSubtitle(text: data?.size?.lsBytes_BytesToString()),
        trailing: LSIconButton(icon: Icons.arrow_forward_ios),
    );
}
