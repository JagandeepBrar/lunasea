import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsConfigurationRssAddRouter extends SettingsPageRouter {
  SettingsConfigurationRssAddRouter()
      : super('/settings/configuration/rss/add');

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
  final FeedHiveObject _feed = FeedHiveObject.empty();

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
      title: 'rss.AddFeed'.tr(),
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
            if (_feed.displayName!.isEmpty ||
                _feed.url!.isEmpty) {
              showLunaErrorSnackBar(
                title: 'Failed to Add Feed',
                message: 'All fields are required',
              );
            } else {
              Database.feeds.box.add(_feed);
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
        _includeFilter(),
        _excludeFilter(),
      ],
    );
  }

  Widget _displayName() {
    String _name = _feed.displayName ?? '';
    return LunaBlock(
      title: 'rss.DisplayName'.tr(),
      body: [TextSpan(text: _name.isEmpty ? 'lunasea.NotSet'.tr() : _name)],
      trailing: const LunaIconButton.arrow(),
      onTap: () async {
        Tuple2<bool, String> values = await LunaDialogs().editText(
          context,
          'rss.DisplayName'.tr(),
          prefill: _name,
        );
        if (values.item1 && mounted) {
          setState(() => _feed.displayName = values.item2);
        }
      },
    );
  }

  Widget _url() {
    String _url = _feed.url ?? '';
    return LunaBlock(
      title: 'rss.FeedUrl'.tr(),
      body: [TextSpan(text: _url.isEmpty ? 'lunasea.NotSet'.tr() : _url)],
      trailing: const LunaIconButton.arrow(),
      onTap: () async {
        Tuple2<bool, String> values = await LunaDialogs().editText(
          context,
          'rss.FeedUrl'.tr(),
          prefill: _url,
        );
        if (values.item1 && mounted) {
          setState(() => _feed.url = values.item2);
        }
      },
    );
  }

  Widget _includeFilter() {
    String _key = _feed.include ?? '';
    return LunaBlock(
      title: 'rss.IncludeFilter'.tr(),
      body: [TextSpan(text: _key.isEmpty ? 'rss.FilterNotSet'.tr() : _key)],
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
    String _key = _feed.exclude ?? '';
    return LunaBlock(
      title: 'rss.ExcludeFilter'.tr(),
      body: [TextSpan(text: _key.isEmpty ? 'rss.FilterNotSet'.tr() : _key)],
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
