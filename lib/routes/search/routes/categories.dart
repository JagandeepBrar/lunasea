import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/routes/search/routes.dart';
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
        await _future;
    }

    Widget get _appBar => LSAppBar(title: Provider.of<SearchModel>(context, listen: false)?.indexer?.displayName ?? 'Categories');

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
            itemBuilder: (context, index) => _card(categories[index], index),
            padBottom: true,
        )
        : LSGenericMessage(
            text: 'No Categories Found',
            showButton: true,
            buttonText: 'Try Again',
            onTapHandler: () => _refreshKey?.currentState?.show(),
        );

    Widget _card(NewznabCategoryData category, int index) => LSCardTile(
        title: LSTitle(text: category.name),
        subtitle: LSSubtitle(text: category.subcategories.length == 0 ? 'No Subcategories Available': category.subcategoriesList),
        leading: LSIconButton(icon: category.icon, color: LSColors.list(index)),
        trailing: LSIconButton(icon: Icons.arrow_forward_ios),
        onTap: () => _enterSubcategories(category),
    );

    Future<void> _enterSubcategories(NewznabCategoryData category) async {
        final model = Provider.of<SearchModel>(context, listen: false);
        model?.category = category;
        model?.searchCategoryID = category.id;
        model?.searchQuery = '';
        category.subcategories.length == 0
            ? Navigator.of(context).pushNamed(SearchResults.ROUTE_NAME)
            : Navigator.of(context).pushNamed(SearchSubcategories.ROUTE_NAME);
    }
}
