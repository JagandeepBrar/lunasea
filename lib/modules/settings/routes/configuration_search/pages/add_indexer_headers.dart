import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsConfigurationSearchAddHeadersRouter extends SettingsPageRouter {
  SettingsConfigurationSearchAddHeadersRouter()
      : super('/settings/configuration/search/add/headers');

  @override
  Widget widget() => _Widget();

  @override
  Future<void> navigateTo(
    BuildContext context, {
    @required IndexerHiveObject indexer,
  }) async {
    LunaRouter.router.navigateTo(
      context,
      route(),
      routeSettings: RouteSettings(arguments: _Arguments(indexer: indexer)),
    );
  }

  @override
  void defineRoute(FluroRouter router) =>
      super.noParameterRouteDefinition(router);
}

class _Arguments {
  final IndexerHiveObject indexer;

  _Arguments({
    @required this.indexer,
  }) {
    assert(indexer != null);
  }
}

class _Widget extends StatefulWidget {
  @override
  State<_Widget> createState() => _State();
}

class _State extends State<_Widget> with LunaScrollControllerMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  _Arguments _arguments;

  @override
  Widget build(BuildContext context) {
    _arguments = ModalRoute.of(context).settings.arguments;
    if (_arguments == null || _arguments.indexer == null)
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
            onTap: () async {
              await HeaderUtility()
                  .addHeader(context, headers: _arguments.indexer.headers);
              if (mounted) setState(() {});
            }),
      ],
    );
  }

  Widget _body() {
    return LunaListView(
      controller: scrollController,
      children: [
        if ((_arguments.indexer.headers ?? {}).isEmpty)
          LunaMessage.inList(text: 'No Headers Added'),
        ..._list(),
      ],
    );
  }

  List<Widget> _list() {
    Map<String, dynamic> headers =
        (_arguments.indexer.headers ?? {}).cast<String, dynamic>();
    List<String> _sortedKeys = headers.keys.toList()..sort();
    return _sortedKeys
        .map<LunaBlock>((key) => _headerTile(key, headers[key]))
        .toList();
  }

  LunaBlock _headerTile(String key, String value) {
    return LunaBlock(
      title: key.toString(),
      body: [TextSpan(text: value.toString())],
      trailing: LunaIconButton(
          icon: LunaIcons.DELETE,
          color: LunaColours.red,
          onPressed: () async {
            await HeaderUtility().deleteHeader(
              context,
              headers: _arguments.indexer.headers,
              key: key,
            );
            if (mounted) setState(() {});
          }),
    );
  }
}
