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
    if (widget.id < 0)
      return InvalidRoutePage(
          title: 'Edit Indexer', message: 'Indexer Not Found');
    if (!LunaBox.indexers.contains(widget.id))
      return InvalidRoutePage(
          title: 'Edit Indexer', message: 'Indexer Not Found');
    return LunaScaffold(
      scaffoldKey: _scaffoldKey,
      appBar: _appBar() as PreferredSizeWidget?,
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
                  title: 'Indexer Deleted', message: _indexer!.displayName);
              _indexer!.delete();
              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }

  Widget _body() {
    return LunaBox.indexers.watch(
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
    return LunaBlock(
      title: 'Display Name',
      body: [
        TextSpan(
          text: _indexer?.displayName.isEmpty ?? true
              ? 'Not Set'
              : _indexer!.displayName,
        ),
      ],
      trailing: const LunaIconButton.arrow(),
      onTap: () async {
        Tuple2<bool, String> values = await LunaDialogs()
            .editText(context, 'Display Name', prefill: _indexer!.displayName);
        if (values.item1) _indexer!.displayName = values.item2;
        _indexer!.save();
      },
    );
  }

  Widget _apiURL() {
    return LunaBlock(
      title: 'Indexer API Host',
      body: [
        TextSpan(
          text: _indexer?.host.isEmpty ?? true ? 'Not Set' : _indexer!.host,
        ),
      ],
      trailing: const LunaIconButton.arrow(),
      onTap: () async {
        Tuple2<bool, String> values = await LunaDialogs()
            .editText(context, 'Indexer API Host', prefill: _indexer!.host);
        if (values.item1) _indexer!.host = values.item2;
        _indexer!.save();
      },
    );
  }

  Widget _apiKey() {
    return LunaBlock(
      title: 'Indexer API Key',
      body: [
        TextSpan(
          text: _indexer?.apiKey.isEmpty ?? true ? 'Not Set' : _indexer!.apiKey,
        ),
      ],
      trailing: const LunaIconButton.arrow(),
      onTap: () async {
        Tuple2<bool, String> values = await LunaDialogs()
            .editText(context, 'Indexer API Key', prefill: _indexer!.apiKey);
        if (values.item1) _indexer!.apiKey = values.item2;
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
