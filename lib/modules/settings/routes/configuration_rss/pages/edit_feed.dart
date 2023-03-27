import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/database/models/rss.dart';
import 'package:lunasea/modules/settings.dart';
import 'package:lunasea/router/routes/settings.dart';
import 'package:lunasea/widgets/pages/invalid_route.dart';

class ConfigurationRssEditFeedRoute extends StatefulWidget {
  final int id;

  const ConfigurationRssEditFeedRoute({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<ConfigurationRssEditFeedRoute> createState() => _State();
}

class _State extends State<ConfigurationRssEditFeedRoute> with LunaScrollControllerMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  LunaRss? _feed;

  @override
  Widget build(BuildContext context) {
    if (widget.id < 0)
      return InvalidRoutePage(
          title: 'Edit Feed', message: 'Feed Not Found');
    if (!LunaBox.rss.contains(widget.id))
      return InvalidRoutePage(
          title: 'Edit Feed', message: 'Feed Not Found');
    return LunaScaffold(
      scaffoldKey: _scaffoldKey,
      appBar: _appBar() as PreferredSizeWidget?,
      body: _body(),
      bottomNavigationBar: _bottomActionBar(),
    );
  }

  Widget _appBar() {
    return LunaAppBar(
      title: 'Edit Feed',
      scrollControllers: [scrollController],
    );
  }

  Widget _bottomActionBar() {
    return LunaBottomActionBar(
      actions: [
        LunaButton.text(
          text: 'Delete Feed',
          icon: Icons.delete_rounded,
          color: LunaColours.red,
          onTap: () async {
            bool result = await SettingsDialogs().deleteIndexer(context);
            if (result) {
              showLunaSuccessSnackBar(
                  title: 'Feed Deleted', message: _feed!.displayName);
              _feed!.delete();
              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }

  Widget _body() {
    return LunaBox.rss.listenableBuilder(
      selectKeys: [widget.id],
      builder: (context, _) {
        if (!LunaBox.rss.contains(widget.id)) return Container();
        _feed = LunaBox.rss.read(widget.id);
        return LunaListView(
          controller: scrollController,
          children: [
            _displayName(),
            _url(),
            _headers(),
            _includeFilter(),
            _excludeFilter(),
          ],
        );
      },
    );
  }

  Widget _displayName() {
    return LunaBlock(
      title: 'rss.DisplayName'.tr(),
      body: [
        TextSpan(
          text: _feed?.displayName.isEmpty ?? true
              ? 'Not Set'
              : _feed!.displayName,
        ),
      ],
      trailing: const LunaIconButton.arrow(),
      onTap: () async {
        Tuple2<bool, String> values = await LunaDialogs().editText(
            context, 'rss.DisplayName'.tr(),
            prefill: _feed!.displayName);
        if (values.item1) _feed!.displayName = values.item2;
        _feed!.save();
      },
    );
  }

  Widget _url() {
    return LunaBlock(
      title: 'rss.FeedUrl'.tr(),
      body: [
        TextSpan(
          text: _feed?.url.isEmpty ?? true ? 'Not Set' : _feed!.url,
        ),
      ],
      trailing: const LunaIconButton.arrow(),
      onTap: () async {
        Tuple2<bool, String> values = await LunaDialogs()
            .editText(context, 'rss.FeedUrl'.tr(), prefill: _feed!.url);
        if (values.item1) _feed!.url = values.item2;
        _feed!.save();
      },
    );
  }

  Widget _headers() {
    return LunaBlock(
      title: 'settings.CustomHeaders'.tr(),
      body: [TextSpan(text: 'settings.CustomHeadersDescription'.tr())],
      trailing: const LunaIconButton.arrow(),
      onTap: () => SettingsRoutes.CONFIGURATION_RSS_EDIT_FEED_HEADERS.go(
        params: {
          'id': widget.id.toString(),
        },
      ),
    );
  }

  Widget _includeFilter() {
    return LunaBlock(
      title: 'rss.IncludeFilter'.tr(),
      body: [
        TextSpan(
          text: _feed?.include.isEmpty ?? true ? 'Not Set' : _feed!.include,
        ),
      ],
      trailing: const LunaIconButton.arrow(),
      onTap: () async {
        Tuple2<bool, String> values = await LunaDialogs().editText(
            context, 'rss.IncludeFilter'.tr(),
            prefill: _feed!.include);
        if (values.item1) _feed!.include = values.item2;
        _feed!.save();
      },
    );
  }

  Widget _excludeFilter() {
    return LunaBlock(
      title: 'rss.ExcludeFilter'.tr(),
      body: [
        TextSpan(
          text: _feed?.exclude.isEmpty ?? true ? 'Not Set' : _feed!.exclude,
        ),
      ],
      trailing: const LunaIconButton.arrow(),
      onTap: () async {
        Tuple2<bool, String> values = await LunaDialogs().editText(
            context, 'rss.ExcludeFilter'.tr(),
            prefill: _feed!.exclude);
        if (values.item1) _feed!.exclude = values.item2;
        _feed!.save();
      },
    );
  }
}
