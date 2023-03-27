import 'package:flutter/material.dart';
import 'package:lunasea/api/rss/models/rss_feed.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/rss/core/state.dart';
import 'package:lunasea/modules/rss/routes/results/widgets/feed_item_tile.dart';

class RssResultsRoute extends StatefulWidget {
  const RssResultsRoute({
    Key? key,
  }) : super(key: key);

  @override
  State<RssResultsRoute> createState() => _State();
}

class _State extends State<RssResultsRoute>
    with LunaLoadCallbackMixin, LunaScrollControllerMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<RefreshIndicatorState> _refreshKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  Future<void> loadCallback() async {
    context.read<RssState>().fetchCurrentFeed();
  }

  Future<void> refreshFeed() async {
    context.read<RssState>().fetchCurrentFeed(update: true);
  }

  @override
  Widget build(BuildContext context) {
    return LunaScaffold(
      scaffoldKey: _scaffoldKey,
      appBar: _appBar() as PreferredSizeWidget?,
      body: _body(),
    );
  }

  Widget _appBar() {
    return LunaAppBar(
      title: context.read<RssState>().feed.displayName,
      scrollControllers: [scrollController],
    );
  }

  Widget _body() {
    return LunaRefreshIndicator(
      context: context,
      key: _refreshKey,
      onRefresh: refreshFeed,
      child: FutureBuilder(
        future: context.watch<RssState>().currentFeed,
        builder: (context, AsyncSnapshot<RssFeed> snapshot) {
          if (snapshot.hasError) {
            LunaLogger().error(
              'Unable to fetch feed',
              snapshot.error,
              snapshot.stackTrace,
            );
            return LunaMessage.error(onTap: _refreshKey.currentState!.show);
          }
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) return _list(snapshot.data!);

          return const LunaLoader();
        },
      ),
    );
  }

  Widget _list(RssFeed feed) {
    if (feed.filteredItems?.isEmpty ?? true) {
      return LunaMessage.goBack(
        context: context,
        text: 'rss.NoItemsFound'.tr(),
      );
    }
    return LunaListViewBuilder(
      controller: scrollController,
      itemCount: feed.filteredItems?.length ?? 0,
      itemBuilder: (context, index) => FeedItemTile(
        item: feed.filteredItems![index],
      ),
    );
  }
}
