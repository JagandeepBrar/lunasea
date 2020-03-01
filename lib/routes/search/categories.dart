import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core/api/newznab.dart';
import 'package:lunasea/core/database.dart';
import 'package:lunasea/routes/search/subcategories.dart';
import 'package:lunasea/widgets/ui.dart';

class SearchCategoriesArguments {
    final IndexerHiveObject indexer;

    SearchCategoriesArguments({
        @required this.indexer,
    });
}

class SearchCategories extends StatefulWidget {
    static const ROUTE_NAME = '/search/categories';

    @override
    State<SearchCategories> createState() =>  _State();
}

class _State extends State<SearchCategories> {
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    final _refreshKey = GlobalKey<RefreshIndicatorState>();
    Future<List<NewznabCategoryData>> _future;
    SearchCategoriesArguments _arguments;

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
        setState(() => { _future = NewznabAPI.from(_arguments?.indexer).getCategories() });
        await _future;
    }

    Widget get _appBar => LSAppBar(title: _arguments?.indexer?.displayName ?? 'Categories');

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

    Widget _list(List<NewznabCategoryData> categories) => LSListViewBuilder(
        itemCount: categories.length,
        itemBuilder: (context, index) => _card(categories[index], index),
        padBottom: true,
    );

    Widget _card(NewznabCategoryData category, int index) => LSCardTile(
        title: LSTitle(text: category.name),
        subtitle: LSSubtitle(text: category.subcategoriesList),
        leading: LSIconButton(icon: category.icon, color: LSColors.list(index)),
        trailing: LSIconButton(icon: Icons.arrow_forward_ios),
        onTap: () => _enterSubcategories(category),
    );

    Future<void> _enterSubcategories(NewznabCategoryData category) async => Navigator.of(context).pushNamed(
        SearchSubcategories.ROUTE_NAME,
        arguments: SearchSubcategoriesArguments(
            category: category,
            indexer: _arguments?.indexer,
        ),
    );
}
