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
    Future<List<NewznabCategoryData>> _future;
    List<NewznabCategoryData> _categories;
    SearchCategoriesArguments _arguments;

    @override
    void initState() {
        super.initState();
        SchedulerBinding.instance.addPostFrameCallback((_) {
            setState(() => _arguments = ModalRoute.of(context).settings.arguments);
            _future = NewznabAPI.from(_arguments?.indexer).getCategories();
        });
    }

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
        body: _arguments == null ? null : _body, 
    );

    Widget get _appBar => LSAppBar(title: _arguments?.indexer?.displayName ?? 'Categories');

    Widget get _body => FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
            switch(snapshot.connectionState) {
                case ConnectionState.waiting:
                case ConnectionState.active: return LSLoading(); break;
                case ConnectionState.none:
                case ConnectionState.done: {
                    if(snapshot.hasError || snapshot.data == null) return LSConnectionError(onTapHandler: null);
                    _categories = snapshot.data;
                }
            }
            return _list;
        },
    );

    Widget get _list => LSListViewBuilder(
        itemCount: _categories.length,
        itemBuilder: (context, index) => _card(_categories[index], index),
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
