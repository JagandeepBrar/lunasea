import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsConfigurationRssEditRouter extends SettingsPageRouter {
  SettingsConfigurationRssEditRouter()
      : super('/settings/configuration/rss/edit/:feedid');

  @override
  _Widget widget([int feedId = -1]) => _Widget(feedId: feedId);

  @override
  Future<void> navigateTo(BuildContext context, [int feedId = -1]) async {
    LunaRouter.router.navigateTo(context, route(feedId));
  }

  @override
  String route([int feedId = -1]) {
    return super.fullRoute.replaceFirst(':feedid', feedId.toString());
  }

  @override
  void defineRoute(FluroRouter router) {
    super.withParameterRouteDefinition(
      router,
      (context, params) {
        int feedId = (params['feedid']?.isNotEmpty ?? false)
            ? (int.tryParse(params['feedid']![0]) ?? -1)
            : -1;
        return _Widget(feedId: feedId);
      },
    );
  }
}

class _Widget extends StatefulWidget {
  final int feedId;

  const _Widget({
    Key? key,
    required this.feedId,
  }) : super(key: key);

  @override
  State<_Widget> createState() => _State();
}

class _State extends State<_Widget> with LunaScrollControllerMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  FeedHiveObject? _feed;

  @override
  Widget build(BuildContext context) {
    if (widget.feedId < 0)
      return LunaInvalidRoute(
          title: 'Edit Feed', message: 'Feed Not Found');
    if (!Database.feeds.box.containsKey(widget.feedId))
      return LunaInvalidRoute(
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
    return ValueListenableBuilder(
        valueListenable:
            Database.feeds.box.listenable(keys: [widget.feedId]),
        builder: (context, dynamic box, __) {
          if (!Database.feeds.box.containsKey(widget.feedId))
            return Container();
          _feed = Database.feeds.box.get(widget.feedId);
          return LunaListView(
            controller: scrollController,
            children: [
              _displayName(),
              _url(),
              _includeFilter(),
              _excludeFilter(),
            ],
          );
        });
  }

  Widget _displayName() {
    return LunaBlock(
      title: 'rss.DisplayName'.tr(),
      body: [
        TextSpan(
          text: _feed!.displayName == null || _feed!.displayName!.isEmpty
              ? 'lunasea.NotSet'.tr()
              : _feed!.displayName,
        ),
      ],
      trailing: const LunaIconButton.arrow(),
      onTap: () async {
        Tuple2<bool, String> values = await LunaDialogs()
            .editText(context, 'rss.DisplayName'.tr(), prefill: _feed!.displayName!);
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
          text: _feed!.url == null || _feed!.url!.isEmpty
              ? 'lunasea.NotSet'.tr()
              : _feed!.url,
        ),
      ],
      trailing: const LunaIconButton.arrow(),
      onTap: () async {
        Tuple2<bool, String> values = await LunaDialogs()
            .editText(context, 'rss.FeedUrl'.tr(), prefill: _feed!.url!);
        if (values.item1) _feed!.url = values.item2;
        _feed!.save();
      },
    );
  }

  Widget _includeFilter() {
    return LunaBlock(
      title: 'rss.IncludeFilter'.tr(),
      body: [
        TextSpan(
          text: _feed!.include == null || _feed!.include!.isEmpty
              ? 'rss.FilterNotSet'.tr()
              : _feed!.include,
        ),
      ],
      trailing: const LunaIconButton.arrow(),
      onTap: () async {
        Tuple2<bool, String> values = await LunaDialogs()
            .editText(context, 'rss.IncludeFilter'.tr(), prefill: _feed!.include!);
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
          text: _feed!.exclude == null || _feed!.exclude!.isEmpty
              ? 'rss.FilterNotSet'.tr()
              : _feed!.exclude,
        ),
      ],
      trailing: const LunaIconButton.arrow(),
      onTap: () async {
        Tuple2<bool, String> values = await LunaDialogs()
            .editText(context, 'rss.ExcludeFilter'.tr(), prefill: _feed!.exclude!);
        if (values.item1) _feed!.exclude = values.item2;
        _feed!.save();
      },
    );
  }
}
