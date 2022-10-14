import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/rss/routes/feeds/widgets/feed_tile.dart';

class RssRoute extends StatefulWidget {
  const RssRoute({
    Key? key,
  }) : super(key: key);

  @override
  State<RssRoute> createState() => _State();
}

class _State extends State<RssRoute> with LunaScrollControllerMixin {
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
    if (LunaBox.rss.isEmpty) {
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
      LunaBox.rss.size,
      (index) => RssFeedTile(
        feed: LunaBox.rss.readAt(index),
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
