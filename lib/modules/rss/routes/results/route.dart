import 'package:flutter/material.dart';
import 'package:lunasea/modules/rss/routes/results/widget/feed_item_tile.dart';

import '../../../../core/mixins/load_callback.dart';
import '../../../../core/mixins/scroll_controller.dart';
import '../../../../core/ui.dart';
import '../../../../core/utilities/logger.dart';
import '../../../../vendor.dart';
import '../../core/state.dart';
import '../../core/types/rss_result_type.dart';
import '../routes.dart';

class RssResultRouter extends RssPageRouter {
  RssResultRouter() : super('/rss/result');

  @override
  void defineRoute(FluroRouter router) {
    super.noParameterRouteDefinition(router);
  }

  @override
  Widget widget() => _Widget();
}

class _Widget extends StatefulWidget {
  @override
  State<_Widget> createState() => _State();
}

class _State extends State<_Widget>
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
      title: context.read<RssState>().feed.displayName ?? 'rss.Feed'.tr(),
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
        builder: (context, AsyncSnapshot<RssResult> snapshot) {
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

  Widget _list(RssResult feedResult) {
    if (feedResult.items.isEmpty) {
      return LunaMessage.goBack(
        context: context,
        text: 'rss.NoItemsFound'.tr(),
      );
    }
    return LunaListViewBuilder(
      controller: scrollController,
      itemCount: feedResult.items.length,
      itemBuilder: (context, index) => FeedItemTile(
        item: feedResult.items[index],
      ),
    );
  }
}
