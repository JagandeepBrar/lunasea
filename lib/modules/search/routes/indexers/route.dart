import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/search.dart';

class SearchHomeRouter extends SearchPageRouter {
  SearchHomeRouter() : super('/search');

  @override
  Widget widget() => _Widget();

  @override
  void defineRoute(FluroRouter router) {
    super.noParameterRouteDefinition(router);
  }
}

class _Widget extends StatefulWidget {
  @override
  State<_Widget> createState() => _State();
}

class _State extends State<_Widget> with LunaScrollControllerMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return LunaScaffold(
      scaffoldKey: _scaffoldKey,
      appBar: _appBar() as PreferredSizeWidget?,
      drawer: _drawer(),
      body: _body(),
    );
  }

  Widget _appBar() {
    return LunaAppBar(
      useDrawer: true,
      title: LunaModule.SEARCH.title,
      scrollControllers: [scrollController],
    );
  }

  Widget _drawer() => LunaDrawer(page: LunaModule.SEARCH.key);

  Widget _body() {
    if (LunaBox.indexers.isEmpty) {
      return LunaMessage.moduleNotEnabled(
        context: context,
        module: LunaModule.SEARCH.title,
      );
    }
    return LunaListView(
      controller: scrollController,
      children: _list,
    );
  }

  List<Widget> get _list {
    final list = LunaBox.indexers.data
        .map((indexer) => SearchIndexerTile(indexer: indexer))
        .toList();
    list.sort((a, b) => a.indexer!.displayName
        .toLowerCase()
        .compareTo(b.indexer!.displayName.toLowerCase()));

    return list;
  }
}
