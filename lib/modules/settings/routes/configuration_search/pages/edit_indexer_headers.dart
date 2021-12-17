import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsConfigurationSearchEditHeadersRouter extends SettingsPageRouter {
  SettingsConfigurationSearchEditHeadersRouter()
      : super('/settings/configuration/search/edit/:indexerid/headers');

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
  String route({@required int indexerId}) =>
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
          title: 'Custom Headers', message: 'Indexer Not Found');
    if (!Database.indexersBox.containsKey(widget.indexerId))
      return LunaInvalidRoute(
          title: 'Custom Headers', message: 'Indexer Not Found');
    return LunaScaffold(
      scaffoldKey: _scaffoldKey,
      appBar: _appBar(),
      body: _body(),
      bottomNavigationBar: _bottomActionBar(),
    );
  }

  Widget _appBar() {
    return LunaAppBar(
      title: 'Custom Headers',
      scrollControllers: [scrollController],
    );
  }

  Widget _bottomActionBar() {
    return LunaBottomActionBar(
      actions: [
        LunaButton.text(
          text: 'Add Header',
          icon: Icons.add_rounded,
          onTap: () async => HeaderUtility()
              .addHeader(context, headers: _indexer.headers, indexer: _indexer),
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
              if ((_indexer.headers ?? {}).isEmpty)
                LunaMessage.inList(text: 'No Headers Added'),
              ..._list(),
            ],
          );
        });
  }

  List<Widget> _list() {
    Map<String, dynamic> headers =
        (_indexer.headers ?? {}).cast<String, dynamic>();
    List<String> _sortedKeys = headers.keys.toList()..sort();
    return _sortedKeys
        .map<LunaBlock>((key) => _headerBlock(key, headers[key]))
        .toList();
  }

  LunaBlock _headerBlock(String key, String value) {
    return LunaBlock(
      title: key.toString(),
      body: [TextSpan(text: value.toString())],
      trailing: LunaIconButton(
        icon: LunaIcons.DELETE,
        color: LunaColours.red,
        onPressed: () async => HeaderUtility().deleteHeader(
          context,
          headers: _indexer.headers,
          key: key,
          indexer: _indexer,
        ),
      ),
    );
  }
}
