import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

import '../../../rss/core/database.dart';
import '../../../rss/core/dialogs.dart';

class SettingsConfigurationRssRouter extends SettingsPageRouter {
  SettingsConfigurationRssRouter() : super('/settings/configuration/rss');

  @override
  _Widget widget() => _Widget();

  @override
  void defineRoute(FluroRouter router) =>
      super.noParameterRouteDefinition(router);
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
      body: _body(),
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  Widget _appBar() {
    return LunaAppBar(
      title: 'RSS',
      scrollControllers: [scrollController],
    );
  }

  Widget _bottomNavigationBar() {
    return LunaBottomActionBar(
      actions: [
        LunaButton.text(
          text: 'Add Feed',
          icon: Icons.add_rounded,
          onTap: () async =>
              SettingsConfigurationRssAddRouter().navigateTo(context),
        ),
      ],
    );
  }

  Widget _body() {
    return ValueListenableBuilder(
      valueListenable: Database.feeds.box.listenable(),
      builder: (context, dynamic box, _) => LunaListView(
        controller: scrollController,
        children: [
          LunaModule.RSS.informationBanner(),
          ..._feedSection(),
          ..._customization(),
        ],
      ),
    );
  }

  List<Widget> _feedSection() => [
        if (Database.feeds.box.isEmpty)
          const LunaMessage(text: 'No Feeds Configured'),
        ..._feeds,
      ];

  List<Widget> get _feeds {
    List<FeedHiveObject> feeds = Database.feeds.box.values.toList();
    feeds.sort((a, b) =>
        a.displayName!.toLowerCase().compareTo(b.displayName!.toLowerCase()));
    List<LunaBlock> list = List.generate(
      feeds.length,
      (index) => _feedTile(feeds[index], feeds[index].key) as LunaBlock,
    );
    return list;
  }

  Widget _feedTile(FeedHiveObject feed, int index) {
    return LunaBlock(
      title: feed.displayName,
      body: [TextSpan(text: feed.url)],
      trailing: const LunaIconButton.arrow(),
      onTap: () async => SettingsConfigurationRssEditRouter().navigateTo(
        context,
        index,
      ),
    );
  }

  List<Widget> _customization() {
    return [
      LunaDivider(),
      _syncRssFeeds(),
      _rssRefreshRate(),
    ];
  }

  Widget _syncRssFeeds() {
    RssDatabaseValue _db = RssDatabaseValue.SYNC;
    return _db.listen(
      builder: (context, box, widget) => LunaBlock(
        title: 'Enable RSS Sync',
        body: const [TextSpan(text: 'Enable RSS Sync')],
        trailing: LunaSwitch(
          value: _db.data,
          onChanged: (value) => _db.put(value),
        ),
      ),
    );
  }

  Widget _rssRefreshRate() {
    RssDatabaseValue _db = RssDatabaseValue.REFRESH_RATE;
    return _db.listen(builder: (context, box, _) {
      String? refreshRate = 'Every ${_db.data} Seconds';
      return LunaBlock(
        title: 'RSS Refresh Rate',
        body: [TextSpan(text: refreshRate)],
        trailing: const LunaIconButton(icon: LunaIcons.REFRESH),
        onTap: () async {
          List<dynamic> _values = await RssDialogs.setRefreshRate(context);
          if (_values[0]) RssDatabaseValue.REFRESH_RATE.put(_values[1]);
        },
      );
    });
  }
}
