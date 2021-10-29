import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsConfigurationSearchEditRouter extends SettingsPageRouter {
  SettingsConfigurationSearchEditRouter()
      : super('/settings/configuration/search/edit/:indexerid');

  @override
  _Widget widget({
    @required int indexerId,
  }) =>
      _Widget(indexerId: indexerId);

  @override
  Future<void> navigateTo(
    BuildContext context, {
    @required int indexerId,
  }) async =>
      LunaRouter.router.navigateTo(context, route(indexerId: indexerId));

  @override
  String route({
    @required int indexerId,
  }) =>
      super.fullRoute.replaceFirst(':indexerid', indexerId?.toString() ?? -1);

  @override
  void defineRoute(FluroRouter router) {
    super.withParameterRouteDefinition(
      router,
      (context, params) {
        int indexerId = (params['indexerid']?.isNotEmpty ?? false)
            ? (int.tryParse(params['indexerid'][0]) ?? -1)
            : -1;
        return _Widget(indexerId: indexerId);
      },
    );
  }
}

class _Widget extends StatefulWidget {
  final int indexerId;

  const _Widget({
    Key key,
    @required this.indexerId,
  }) : super(key: key);

  @override
  State<_Widget> createState() => _State();
}

class _State extends State<_Widget> with LunaScrollControllerMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  IndexerHiveObject _indexer;

  @override
  Widget build(BuildContext context) {
    if (widget.indexerId < 0)
      return LunaInvalidRoute(
          title: 'Edit Indexer', message: 'Indexer Not Found');
    if (!Database.indexersBox.containsKey(widget.indexerId))
      return LunaInvalidRoute(
          title: 'Edit Indexer', message: 'Indexer Not Found');
    return LunaScaffold(
      scaffoldKey: _scaffoldKey,
      appBar: _appBar(),
      body: _body(),
      bottomNavigationBar: _bottomActionBar(),
    );
  }

  Widget _appBar() {
    return LunaAppBar(
      title: 'Edit Indexer',
      scrollControllers: [scrollController],
    );
  }

  Widget _bottomActionBar() {
    return LunaBottomActionBar(
      actions: [
        LunaButton.text(
          text: 'Delete Indexer',
          icon: Icons.delete_rounded,
          color: LunaColours.red,
          onTap: () async {
            bool result = await SettingsDialogs().deleteIndexer(context);
            if (result) {
              showLunaSuccessSnackBar(
                  title: 'Indexer Deleted', message: _indexer.displayName);
              _indexer.delete();
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
            Database.indexersBox.listenable(keys: [widget.indexerId]),
        builder: (context, box, __) {
          if (!Database.indexersBox.containsKey(widget.indexerId))
            return Container();
          _indexer = Database.indexersBox.get(widget.indexerId);
          return LunaListView(
            controller: scrollController,
            children: [
              _displayName(),
              _apiURL(),
              _apiKey(),
              _headers(),
            ],
          );
        });
  }

  Widget _displayName() {
    return LunaListTile(
      context: context,
      title: LunaText.title(text: 'Display Name'),
      subtitle: LunaText.subtitle(
          text: _indexer.displayName == null || _indexer.displayName.isEmpty
              ? 'Not Set'
              : _indexer.displayName),
      trailing: LunaIconButton(icon: Icons.arrow_forward_ios_rounded),
      onTap: () async {
        Tuple2<bool, String> values = await LunaDialogs()
            .editText(context, 'Display Name', prefill: _indexer.displayName);
        if (values.item1) _indexer.displayName = values.item2;
        _indexer.save();
      },
    );
  }

  Widget _apiURL() {
    return LunaListTile(
      context: context,
      title: LunaText.title(text: 'Indexer API Host'),
      subtitle: LunaText.subtitle(
          text: _indexer.host == null || _indexer.host.isEmpty
              ? 'Not Set'
              : _indexer.host),
      trailing: LunaIconButton(icon: Icons.arrow_forward_ios_rounded),
      onTap: () async {
        Tuple2<bool, String> values = await LunaDialogs()
            .editText(context, 'Indexer API Host', prefill: _indexer.host);
        if (values.item1) _indexer.host = values.item2;
        _indexer.save();
      },
    );
  }

  Widget _apiKey() {
    return LunaListTile(
      context: context,
      title: LunaText.title(text: 'Indexer API Key'),
      subtitle: LunaText.subtitle(
          text: _indexer.apiKey == null || _indexer.apiKey.isEmpty
              ? 'Not Set'
              : _indexer.apiKey),
      trailing: LunaIconButton(icon: Icons.arrow_forward_ios_rounded),
      onTap: () async {
        Tuple2<bool, String> values = await LunaDialogs()
            .editText(context, 'Indexer API Key', prefill: _indexer.apiKey);
        if (values.item1) _indexer.apiKey = values.item2;
        _indexer.save();
      },
    );
  }

  Widget _headers() {
    return LunaListTile(
      context: context,
      title: LunaText.title(text: 'Custom Headers'),
      subtitle: LunaText.subtitle(text: 'Add Custom Headers to Requests'),
      trailing: LunaIconButton(icon: Icons.arrow_forward_ios_rounded),
      onTap: () async => SettingsConfigurationSearchEditHeadersRouter()
          .navigateTo(context, indexerId: widget.indexerId),
    );
  }
}
