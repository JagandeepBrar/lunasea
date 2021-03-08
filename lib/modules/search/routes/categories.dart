import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/search.dart';

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
        _refresh();
    }

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
        body: _body, 
    );

    Future<void> _refresh() async {
        final model = Provider.of<SearchState>(context, listen: false);
        if(mounted) setState(() {
            _future = NewznabAPI.from(model?.indexer)?.getCategories();
        });
    }

    Widget get _appBar => LunaAppBar(
        title: Provider.of<SearchState>(context, listen: false)?.indexer?.displayName ?? 'Categories',
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
                        if(snapshot.hasError || snapshot.data == null) {
                            LunaLogger().error('Unable to fetch categories', snapshot.error, snapshot.stackTrace);
                            return LSErrorMessage(onTapHandler: () => _refresh());
                        }
                        return _list(snapshot.data);
                    }
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                    case ConnectionState.active:
                    default: return LSLoader();
                }
            },
        ),
    );

    Widget _list(List<NewznabCategoryData> categories) => categories.length > 0
        ? LSListViewBuilder(
            itemCount: categories.length,
            itemBuilder: (context, index) => _hideCategory(categories[index])
                ? Container()
                : SearchCategoryTile(category: categories[index], index: index),
        )
        : LSGenericMessage(
            text: 'No Categories Found',
            showButton: true,
            buttonText: 'Try Again',
            onTapHandler: () => _refresh(),
        );

    Future<void> _enterSearch() async {
        final model = Provider.of<SearchState>(context, listen: false);
        model.searchTitle = '${model?.indexer?.displayName}';
        model.searchCategoryID = -1;
        model.searchQuery = '';
        await Navigator.of(context).pushNamed(SearchSearch.ROUTE_NAME);
    }

    bool _hideCategory(NewznabCategoryData category) {
        // If the setting is not enabled, return false for any category
        if(!SearchDatabaseValue.HIDE_XXX.data) return false;
        // Checks the category ID and returns true if it is between 6000-7000
        if(category.id >= 6000 && category.id <= 6999) return true;
        // Compares the name to the list of adult categories, return true if it matches any, false if it doesn't
        if(SearchConstants.ADULT_CATEGORIES.contains(category.name.toLowerCase().trim())) return true;
        return false;
    }
}
