import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/routes/search/routes.dart';
import 'package:lunasea/widgets/ui.dart';

class SearchResults extends StatefulWidget {
    static const ROUTE_NAME = '/search/results';

    @override
    State<SearchResults> createState() =>  _State();
}

class _State extends State<SearchResults> {
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    Future<List<NewznabResultData>> _future;

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
        setState(() => { _future = NewznabAPI.from(model?.indexer).getResults(
            categoryId: model?.searchCategoryID,
            query: model?.searchQuery,
        )});
        await _future;
    }

    Widget get _appBar => LSAppBar(title: 'Results');

    Widget get _body => LSRefreshIndicator(
        onRefresh: _refresh,
        child: FutureBuilder(
            future: _future,
            builder: (context, snapshot) {
                switch(snapshot.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.done: {
                        if(snapshot.hasError || snapshot.data == null) return LSErrorMessage(onTapHandler: _refresh);
                        return _list(snapshot.data);
                    }
                    case ConnectionState.waiting:
                    case ConnectionState.active:
                    default: return LSLoading();
                }
            },
        ),
    );

    Widget _list(List<NewznabResultData> results) => LSListViewBuilder(
        itemCount: results.length,
        itemBuilder: (context, index) => _card(results[index]),
    );

    Widget _card(NewznabResultData data) => LSCardTile(
        title: LSTitle(text: data.title),
        subtitle: LSSubtitle(text: data?.size?.lsBytes_BytesToString()),
        trailing: LSIconButton(icon: Icons.arrow_forward_ios),
        onTap: () async => _enterDetails(data),
    );

    Future<void> _enterDetails(NewznabResultData result) async {
        Provider.of<SearchModel>(context, listen: false)?.resultDetails = result;
        Navigator.of(context).pushNamed(SearchDetails.ROUTE_NAME);
    }
}
