import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsConfigurationSearchAddRouter extends SettingsPageRouter {
  SettingsConfigurationSearchAddRouter()
      : super('/settings/configuration/search/add');

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
  final IndexerHiveObject _indexer = IndexerHiveObject.empty();

  @override
  Widget build(BuildContext context) {
    return LunaScaffold(
      scaffoldKey: _scaffoldKey,
      appBar: _appBar(),
      body: _body(),
      bottomNavigationBar: _bottomActionBar(),
    );
  }

  Widget _appBar() {
    return LunaAppBar(
      title: 'Add Indexer',
      scrollControllers: [scrollController],
    );
  }

  Widget _bottomActionBar() {
    return LunaBottomActionBar(
      actions: [
        LunaButton.text(
          text: 'Add Indexer',
          icon: Icons.add_rounded,
          onTap: () async {
            if (_indexer.displayName.isEmpty ||
                _indexer.host.isEmpty ||
                _indexer.apiKey.isEmpty) {
              showLunaErrorSnackBar(
                title: 'Failed to Add Indexer',
                message: 'All fields are required',
              );
            } else {
              Database.indexersBox.add(_indexer);
              showLunaSuccessSnackBar(
                title: 'Indexer Added',
                message: _indexer.displayName,
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
        _apiURL(),
        _apiKey(),
        _headers(),
      ],
    );
  }

  Widget _displayName() {
    String _name = _indexer.displayName ?? '';
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
          setState(() => _indexer.displayName = values.item2);
        }
      },
    );
  }

  Widget _apiURL() {
    String _host = _indexer.host ?? '';
    return LunaBlock(
      title: 'Indexer API Host',
      body: [TextSpan(text: _host.isEmpty ? 'lunasea.NotSet'.tr() : _host)],
      trailing: const LunaIconButton.arrow(),
      onTap: () async {
        Tuple2<bool, String> values = await LunaDialogs().editText(
          context,
          'Indexer API Host',
          prefill: _host,
        );
        if (values.item1 && mounted) {
          setState(() => _indexer.host = values.item2);
        }
      },
    );
  }

  Widget _apiKey() {
    String _key = _indexer.apiKey ?? '';
    return LunaBlock(
      title: 'Indexer API Key',
      body: [TextSpan(text: _key.isEmpty ? 'lunasea.NotSet'.tr() : _key)],
      trailing: const LunaIconButton.arrow(),
      onTap: () async {
        Tuple2<bool, String> values = await LunaDialogs().editText(
          context,
          'Indexer API Key',
          prefill: _key,
        );
        if (values.item1 && mounted) {
          setState(() => _indexer.apiKey = values.item2);
        }
      },
    );
  }

  Widget _headers() {
    return LunaBlock(
      title: 'settings.CustomHeaders'.tr(),
      body: [TextSpan(text: 'settings.CustomHeadersDescription'.tr())],
      trailing: const LunaIconButton.arrow(),
      onTap: () async => SettingsConfigurationSearchAddHeadersRouter()
          .navigateTo(context, indexer: _indexer),
    );
  }
}
