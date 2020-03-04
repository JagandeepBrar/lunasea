import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/widgets/pages/search/subcategories.dart';
import 'package:lunasea/widgets/ui.dart';

class SearchSubcategories extends StatefulWidget {
    static const ROUTE_NAME = '/search/subcategories';

    @override
    State<SearchSubcategories> createState() =>  _State();
}

class _State extends State<SearchSubcategories> {
    final _scaffoldKey = GlobalKey<ScaffoldState>();

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
        body: _body, 
    );

    Widget get _appBar => LSAppBar(title: Provider.of<SearchModel>(context, listen: false)?.category?.name ?? 'Subcategories');

    Widget get _body => Consumer<SearchModel>(
        builder: (context, _state, child) => LSListViewBuilder(
            itemCount: (_state?.category?.subcategories?.length ?? 0)+1,
            itemBuilder: (context, index) => LSSearchSubcategoriesTile(
                category: _state?.category,
                index: index-1,
                allSubcategories: index == 0,
            ),
            padBottom: true,
        ),
    );
}
