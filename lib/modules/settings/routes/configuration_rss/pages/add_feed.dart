import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/database/models/rss.dart';
import 'package:lunasea/router/routes/settings.dart';

class ConfigurationRssAddFeedRoute extends StatefulWidget {
  const ConfigurationRssAddFeedRoute({
    Key? key,
  }) : super(key: key);

  @override
  State<ConfigurationRssAddFeedRoute> createState() => _State();
}

class _State extends State<ConfigurationRssAddFeedRoute> with LunaScrollControllerMixin {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _feed = LunaRss();

  @override
  Widget build(BuildContext context) {
    return LunaScaffold(
      scaffoldKey: _scaffoldKey,
      appBar: _appBar() as PreferredSizeWidget?,
      body: _body(),
      bottomNavigationBar: _bottomActionBar(),
    );
  }

  Widget _appBar() {
    return LunaAppBar(
      title: 'Add Feed',
      scrollControllers: [scrollController],
    );
  }

  Widget _bottomActionBar() {
    return LunaBottomActionBar(
      actions: [
        LunaButton.text(
          text: 'Add Feed',
          icon: Icons.add_rounded,
          onTap: () async {
            if (_feed.displayName.isEmpty ||
                _feed.url.isEmpty) {
              showLunaErrorSnackBar(
                title: 'Failed to Add Feed',
                message: 'All fields are required',
              );
            } else {
              LunaBox.rss.create(_feed);
              showLunaSuccessSnackBar(
                title: 'Feed Added',
                message: _feed.displayName,
              );
              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }

  Widget _body() {
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
  }

  Widget _displayName() {
    String _name = _feed.displayName;
    return LunaBlock(
      title: 'Display Name',
      body: [TextSpan(text: _name.isEmpty ? 'lunasea.NotSet'.tr() : _name)],
      trailing: const LunaIconButton.arrow(),
      onTap: () async {
        Tuple2<bool, String> values = await LunaDialogs().editText(
          context,
          'Display Name',
          prefill: _name,
        );
        if (values.item1 && mounted) {
          setState(() => _feed.displayName = values.item2);
        }
      },
    );
  }

  Widget _url() {
    String _url = _feed.url;
    return LunaBlock(
      title: 'Url',
      body: [TextSpan(text: _url.isEmpty ? 'lunasea.NotSet'.tr() : _url)],
      trailing: const LunaIconButton.arrow(),
      onTap: () async {
        Tuple2<bool, String> values = await LunaDialogs().editText(
          context,
          'Url',
          prefill: _url,
        );
        if (values.item1 && mounted) {
          setState(() => _feed.url = values.item2);
        }
      },
    );
  }

  Widget _headers() {
    return LunaBlock(
      title: 'settings.CustomHeaders'.tr(),
      body: [TextSpan(text: 'settings.CustomHeadersDescription'.tr())],
      trailing: const LunaIconButton.arrow(),
      onTap: () => SettingsRoutes.CONFIGURATION_RSS_ADD_FEED_HEADERS.go(
        extra: _feed,
      ),
    );
  }

  Widget _includeFilter() {
    String _key = _feed.include;
    return LunaBlock(
      title: 'rss.IncludeFilter'.tr(),
      body: [
        TextSpan(
            text: _key.isEmpty
                ? "${'rss.FilterNotSet'.tr()} ${"rss.IncludeFilterHelp".tr()}"
                : _key)
      ],
      trailing: const LunaIconButton.arrow(),
      onTap: () async {
        Tuple2<bool, String> values = await LunaDialogs().editText(
          context,
          'rss.IncludeFilter'.tr(),
          prefill: _key,
        );
        if (values.item1 && mounted) {
          setState(() => _feed.include = values.item2);
        }
      },
    );
  }

  Widget _excludeFilter() {
    String _key = _feed.exclude;
    return LunaBlock(
      title: 'rss.ExcludeFilter'.tr(),
      body: [
        TextSpan(
            text: _key.isEmpty
                ? "${'rss.FilterNotSet'.tr()} ${"rss.ExcludeFilterHelp".tr()}"
                : _key)
      ],
      trailing: const LunaIconButton.arrow(),
      onTap: () async {
        Tuple2<bool, String> values = await LunaDialogs().editText(
          context,
          'rss.ExcludeFilter'.tr(),
          prefill: _key,
        );
        if (values.item1 && mounted) {
          setState(() => _feed.exclude = values.item2);
        }
      },
    );
  }
}
