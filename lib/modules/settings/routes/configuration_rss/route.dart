import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/database/models/rss.dart';
import 'package:lunasea/database/tables/rss.dart';
import 'package:lunasea/modules/rss/core/dialogs.dart';
import 'package:lunasea/router/routes/settings.dart';


class ConfigurationRssRoute extends StatefulWidget {
  const ConfigurationRssRoute({
    Key? key,
  }) : super(key: key);

  @override
  State<ConfigurationRssRoute> createState() => _State();
}

class _State extends State<ConfigurationRssRoute> with LunaScrollControllerMixin {
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
          text: 'rss.AddFeed'.tr(),
          icon: Icons.add_rounded,
          onTap: SettingsRoutes.CONFIGURATION_RSS_ADD_FEED.go,
        )
      ],
    );
  }

  Widget _body() {
    return ValueListenableBuilder(
      valueListenable: LunaBox.rss.listenable(),
      builder: (context, dynamic box, _) => LunaListView(
        controller: scrollController,
        children: [
          LunaModule.RSS.informationBanner(),
          ..._feedSection(),
          //TODO for a future version ..._customization(),
        ],
      ),
    );
  }

  List<Widget> _feedSection() => [
        if (LunaBox.rss.isEmpty)
          const LunaMessage(text: 'No Feeds Configured'),
        ..._feeds,
      ];

  List<Widget> get _feeds {
    List<LunaRss> feeds = LunaBox.rss.data.toList();
    feeds.sort((a, b) =>
        a.displayName.toLowerCase().compareTo(b.displayName.toLowerCase()));
    List<LunaBlock> list = List.generate(
      feeds.length,
      (index) => _feedTile(feeds[index], feeds[index].key) as LunaBlock,
    );
    return list;
  }

  Widget _feedTile(LunaRss feed, int index) {
    return LunaBlock(
      title: feed.displayName,
      body: [TextSpan(text: feed.url)],
      trailing: const LunaIconButton.arrow(),
      onTap: () async {
        SettingsRoutes.CONFIGURATION_RSS_EDIT_FEED.go(params: {
          'id': index.toString(),
        });
      },
    );
  }

  List<Widget> _customization() {
    return [
      LunaDivider(),
      _rssRefreshRate(),
    ];
  }


  Widget _rssRefreshRate() {
    const _db = RssDatabase.REFRESH_RATE;
    return _db.listenableBuilder(builder: (context, _) {
      String? refreshRate;
      if (_db.read() == 1) refreshRate = 'Every Second';
      if (_db.read() != 1) refreshRate = 'Every ${_db.read()} Seconds';
      return LunaBlock(
        title: 'RSS Refresh Rate',
        body: [TextSpan(text: refreshRate)],
        trailing: const LunaIconButton(icon: LunaIcons.REFRESH),
        onTap: () async {
          List<dynamic> _values = await RssDialogs.setRefreshRate(context);
          if (_values[0]) _db.update(_values[1]);
        },
      );
    });
  }
}
