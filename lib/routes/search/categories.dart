import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core/database.dart';
import 'package:lunasea/widgets/ui.dart';

class SearchCategoriesArguments {
    final IndexerHiveObject indexer;

    SearchCategoriesArguments({
        @required this.indexer,
    });
}

class SearchCatagories extends StatefulWidget {
    static const ROUTE_NAME = '/search/categories';

    @override
    State<SearchCatagories> createState() =>  _State();
}

class _State extends State<SearchCatagories> {
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    SearchCategoriesArguments _arguments;

    @override
    void initState() {
        super.initState();
        SchedulerBinding.instance.addPostFrameCallback((_) => 
            setState(() => _arguments = ModalRoute.of(context).settings.arguments)
        );
    }

    @override
    Widget build(BuildContext context) => ValueListenableBuilder(
        valueListenable: Database.indexersBox.listenable(),
        builder: (context, indexerBox, widget) => Scaffold(
            key: _scaffoldKey,
            appBar: _appBar,
            body: _arguments == null ? null : _body,
        ),
    );

    Widget get _appBar => LSAppBar(title: 'Categories');

    Widget get _body => Text('Categories');
}
