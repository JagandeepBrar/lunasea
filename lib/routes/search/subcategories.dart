import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core/api/newznab.dart';
import 'package:lunasea/core/database/indexer.dart';
import 'package:lunasea/routes/search/routes.dart';
import 'package:lunasea/widgets/ui.dart';

class SearchSubcategoriesArguments {
    final NewznabCategoryData category;
    final IndexerHiveObject indexer;

    SearchSubcategoriesArguments({
        @required this.category,
        @required this.indexer,
    });
}

class SearchSubcategories extends StatefulWidget {
    static const ROUTE_NAME = '/search/subcategories';

    @override
    State<SearchSubcategories> createState() =>  _State();
}

class _State extends State<SearchSubcategories> {
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    SearchSubcategoriesArguments _arguments;

    @override
    void initState() {
        super.initState();
        SchedulerBinding.instance.addPostFrameCallback((_) => setState(() => 
            _arguments = ModalRoute.of(context).settings.arguments)
        );
    }

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
        body: _body, 
    );

    Widget get _appBar => LSAppBar(title: _arguments?.category?.name ?? 'Subcategories');

    Widget get _body => _arguments == null ? null : _list;

    Widget get _list => LSListViewBuilder(
        itemCount: (_arguments?.category?.subcategories?.length ?? 0)+1,
        itemBuilder: (context, index) => index == 0
            ? _cardAll()
            : _card(_arguments?.category?.subcategories[index-1], index),
        padBottom: true,
    );

    Widget _card(NewznabSubcategoryData subcategory, int index) => LSCardTile(
        title: LSTitle(text: subcategory.name),
        subtitle: LSSubtitle(text: '${_arguments?.category?.name} > ${subcategory.name}'),
        trailing: LSIconButton(icon: Icons.arrow_forward_ios),
        leading: LSIconButton(icon: _arguments?.category?.icon, color: LSColors.list(index)),
        onTap: () => _enterResults(subcategory.id),
    );

    Widget _cardAll() => LSCardTile(
        title: LSTitle(text: 'All Subcategories'),
        subtitle: LSSubtitle(text: '${_arguments?.category?.name} > All'),
        leading: LSIconButton(icon: _arguments?.category?.icon, color: LSColors.list(0)),
        trailing: LSIconButton(icon: Icons.arrow_forward_ios),
        onTap: () => _enterResults(_arguments?.category?.id),
    );

    Future<void> _enterResults(int categoryId) async => Navigator.of(context).pushNamed(
        SearchResults.ROUTE_NAME,
        arguments: SearchResultsArguments(
            indexer: _arguments?.indexer,
            category: categoryId,
            query: '',
        ),
    );
}
