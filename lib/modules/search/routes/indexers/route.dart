import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/search.dart';

class SearchHomeRouter extends LunaPageRouter {
    SearchHomeRouter(): super('/search');

    @override
    void defineRoute(FluroRouter router) => super.noParameterRouteDefinition(router, _SearchHomeRoute());
}

class _SearchHomeRoute extends StatefulWidget {
    @override
    State<_SearchHomeRoute> createState() =>  _State();
}

class _State extends State<_SearchHomeRoute> with LunaScrollControllerMixin {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    Future<bool> _onWillPop() async {
        if(_scaffoldKey.currentState.isDrawerOpen) return true;
        _scaffoldKey.currentState.openDrawer();
        return false;
    }

    @override
    Widget build(BuildContext context) {
        return WillPopScope(
            onWillPop: _onWillPop,
            child: ValueListenableBuilder(
                valueListenable: Database.indexersBox.listenable(),
                builder: (context, indexerBox, widget) => Scaffold(
                    key: _scaffoldKey,
                    appBar: _appBar(),
                    drawer: _drawer(),
                    body: _body(),
                ),
            ),
        );
    }

    Widget _appBar() {
        return LunaAppBar(
            useDrawer: true,
            title: 'Search',
            scrollControllers: [scrollController],
        );
    }

    Widget _drawer() => LunaDrawer(page: LunaModule.SEARCH.key);

    Widget _body() {
        if((Database.indexersBox.length ?? 0) == 0) return LunaMessage.moduleNotEnabled(
            context: context,
            module: LunaModule.SEARCH.name,
        );
        return LunaListView(
            controller: scrollController,
            children: _list,
        );
    }

    List get _list {
        List<SearchIndexerTile> list = List.generate(
            Database.indexersBox.length,
            (index) => SearchIndexerTile(indexer: Database.indexersBox.getAt(index)),
        );
        list.sort((a,b) => a.indexer.displayName.compareTo(b.indexer.displayName));
        return list;
    }
}
