import 'package:flutter/material.dart';

import '../../../../core/database/database.dart';
import '../../../../core/mixins/scroll_controller.dart';
import '../../../../core/modules.dart';
import '../../../../core/ui.dart';
import '../../../../vendor.dart';
import '../routes.dart';
import 'widgets/feed_tile.dart';

class RssHomeRouter extends RssPageRouter {
  RssHomeRouter() : super('/rss');

  @override
  Home widget() => const Home();

  @override
  void defineRoute(FluroRouter router) {
    super.noParameterRouteDefinition(router);
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _State();
}

class _State extends State<Home> with LunaScrollControllerMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return LunaScaffold(
      scaffoldKey: _scaffoldKey,
      module: LunaModule.RSS,
      appBar: _appBar() as PreferredSizeWidget?,
      drawer: _drawer(),
      body: _body(),
    );
  }

  Widget _appBar() {
    return LunaAppBar(
      useDrawer: true,
      title: LunaModule.RSS.name,
      scrollControllers: [scrollController],
    );
  }

  Widget _drawer() => LunaDrawer(page: LunaModule.RSS.key);

  Widget _body() {
    if (Database.feeds.box.isEmpty) {
      return LunaMessage.moduleNotEnabled(
        context: context,
        module: LunaModule.RSS.name,
      );
    }
    return LunaListView(
      controller: scrollController,
      children: _list as List<Widget>,
    );
  }

  List get _list {
    List<RssFeedTile> list = List.generate(
      Database.feeds.box.length,
      (index) => RssFeedTile(
        feed: Database.feeds.box.getAt(index),
      ),
    );
    list.sort(
      (a, b) => a.feed!.displayName!
          .toLowerCase()
          .compareTo(b.feed!.displayName!.toLowerCase()),
    );
    return list;
  }
}
