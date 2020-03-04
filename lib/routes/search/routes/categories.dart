import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/routes/search/routes.dart';
import 'package:lunasea/widgets/pages/search.dart';
import 'package:lunasea/widgets/ui.dart';

class SearchCategories extends StatefulWidget {
    static const ROUTE_NAME = '/search/categories';

    @override
    State<SearchCategories> createState() =>  _State();
}

class _State extends State<SearchCategories> {
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    final _refreshKey = GlobalKey<RefreshIndicatorState>();
    Future<List<NewznabCategoryData>> _future;

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
        setState(() => { _future = NewznabAPI.from(model?.indexer)?.getCategories() });
        //Keep the indicator showing by waiting for the future
        _future.catchError((error) => {});
    }

    Widget get _appBar => LSAppBar(
        title: Provider.of<SearchModel>(context, listen: false)?.indexer?.displayName ?? 'Categories',
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
                        if(snapshot.hasError || snapshot.data == null) return LSErrorMessage(onTapHandler: () => _refreshKey?.currentState?.show());
                        return _list(snapshot.data);
                    }
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                    case ConnectionState.active:
                    default: return LSLoading();
                }
            },
        ),
    );

    Widget _list(List<NewznabCategoryData> categories) => categories.length > 0
        ? LSListViewBuilder(
            itemCount: categories.length,
            itemBuilder: (context, index) => LSSearchCategoryTile(category: categories[index], index: index),
            padBottom: true,
        )
        : LSGenericMessage(
            text: 'No Categories Found',
            showButton: true,
            buttonText: 'Try Again',
            onTapHandler: () => _refreshKey?.currentState?.show(),
        );

    Future<void> _enterSearch() async {
        await Navigator.of(context).pushNamed(SearchSearch.ROUTE_NAME);
    }
}
