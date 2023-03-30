import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/database/models/indexer.dart';
import 'package:lunasea/modules/settings.dart';
import 'package:lunasea/widgets/pages/invalid_route.dart';
import 'package:lunasea/router/routes/settings.dart';

class ConfigurationSearchEditIndexerRoute extends StatefulWidget {
  final int id;

  const ConfigurationSearchEditIndexerRoute({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<ConfigurationSearchEditIndexerRoute> createState() => _State();
}

class _State extends State<ConfigurationSearchEditIndexerRoute>
    with LunaScrollControllerMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  LunaIndexer? _indexer;

  @override
  Widget build(BuildContext context) {
    if (widget.id < 0 || !LunaBox.indexers.contains(widget.id)) {
      return InvalidRoutePage(
        title: 'search.EditIndexer'.tr(),
        message: 'search.IndexerNotFound'.tr(),
      );
    }

    return LunaScaffold(
      scaffoldKey: _scaffoldKey,
      appBar: _appBar(),
      body: _body(),
      bottomNavigationBar: _bottomActionBar(),
    );
  }

  PreferredSizeWidget _appBar() {
    return LunaAppBar(
      title: 'search.EditIndexer'.tr(),
      scrollControllers: [scrollController],
    );
  }

  Widget _bottomActionBar() {
    return LunaBottomActionBar(
      actions: [
        LunaButton.text(
          text: 'search.DeleteIndexer'.tr(),
          icon: Icons.delete_rounded,
          color: LunaColours.red,
          onTap: () async {
            bool result = await SettingsDialogs().deleteIndexer(context);
            if (result) {
              showLunaSuccessSnackBar(
                title: 'search.IndexerDeleted'.tr(),
                message: _indexer!.displayName,
              );
              _indexer!.delete();
              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }

  Widget _body() {
    return LunaBox.indexers.listenableBuilder(
      selectKeys: [widget.id],
      builder: (context, _) {
        if (!LunaBox.indexers.contains(widget.id)) return Container();
        _indexer = LunaBox.indexers.read(widget.id);
        return LunaListView(
          controller: scrollController,
          children: [
            _displayName(),
            _apiURL(),
            _apiKey(),
            _headers(),
          ],
        );
      },
    );
  }

  Widget _displayName() {
    String _name = _indexer!.displayName;
    return LunaBlock(
      title: 'settings.DisplayName'.tr(),
      body: [TextSpan(text: _name.isEmpty ? 'lunasea.NotSet'.tr() : _name)],
      trailing: const LunaIconButton.arrow(),
      onTap: () async {
        Tuple2<bool, String> values = await LunaDialogs().editText(
          context,
          'settings.DisplayName'.tr(),
          prefill: _indexer!.displayName,
        );
        if (values.item1) {
          _indexer!.displayName = values.item2;
        }
        _indexer!.save();
      },
    );
  }

  Widget _apiURL() {
    String _host = _indexer!.host;
    return LunaBlock(
      title: 'search.IndexerAPIHost'.tr(),
      body: [TextSpan(text: _host.isEmpty ? 'lunasea.NotSet'.tr() : _host)],
      trailing: const LunaIconButton.arrow(),
      onTap: () async {
        Tuple2<bool, String> values = await LunaDialogs().editText(
          context,
          'search.IndexerAPIHost'.tr(),
          prefill: _host,
        );
        if (values.item1 && mounted) {
          _indexer!.host = values.item2;
        }
        _indexer!.save();
      },
    );
  }

  Widget _apiKey() {
    String _key = _indexer!.apiKey;
    return LunaBlock(
      title: 'search.IndexerAPIKey'.tr(),
      body: [TextSpan(text: _key.isEmpty ? 'lunasea.NotSet'.tr() : _key)],
      trailing: const LunaIconButton.arrow(),
      onTap: () async {
        Tuple2<bool, String> values = await LunaDialogs().editText(
          context,
          'search.IndexerAPIKey'.tr(),
          prefill: _key,
        );
        if (values.item1) {
          _indexer!.apiKey = values.item2;
        }
        _indexer!.save();
      },
    );
  }

  Widget _headers() {
    return LunaBlock(
      title: 'settings.CustomHeaders'.tr(),
      body: [TextSpan(text: 'settings.CustomHeadersDescription'.tr())],
      trailing: const LunaIconButton.arrow(),
      onTap: () => SettingsRoutes.CONFIGURATION_SEARCH_EDIT_INDEXER_HEADERS.go(
        params: {
          'id': widget.id.toString(),
        },
      ),
    );
  }
}
