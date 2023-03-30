import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/database/models/indexer.dart';
import 'package:lunasea/modules/settings.dart';
import 'package:lunasea/widgets/pages/invalid_route.dart';

class ConfigurationSearchAddIndexerHeadersRoute extends StatefulWidget {
  final LunaIndexer? indexer;

  const ConfigurationSearchAddIndexerHeadersRoute({
    Key? key,
    required this.indexer,
  }) : super(key: key);

  @override
  State<ConfigurationSearchAddIndexerHeadersRoute> createState() => _State();
}

class _State extends State<ConfigurationSearchAddIndexerHeadersRoute>
    with LunaScrollControllerMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    if (widget.indexer == null) {
      return InvalidRoutePage(
        title: 'settings.CustomHeaders'.tr(),
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
      title: 'settings.CustomHeaders'.tr(),
      scrollControllers: [scrollController],
    );
  }

  Widget _bottomActionBar() {
    return LunaBottomActionBar(
      actions: [
        LunaButton.text(
          text: 'settings.AddHeader'.tr(),
          icon: Icons.add_rounded,
          onTap: () async {
            await HeaderUtility()
                .addHeader(context, headers: widget.indexer!.headers);
            if (mounted) setState(() {});
          },
        ),
      ],
    );
  }

  Widget _body() {
    return LunaListView(
      controller: scrollController,
      children: [
        if (widget.indexer!.headers.isEmpty)
          LunaMessage.inList(text: 'settings.NoHeadersAdded'.tr()),
        ..._list(),
      ],
    );
  }

  List<Widget> _list() {
    final headers = widget.indexer!.headers.cast<String, dynamic>();
    List<String> _sortedKeys = headers.keys.toList()..sort();
    return _sortedKeys
        .map<LunaBlock>((key) => _headerTile(key, headers[key]))
        .toList();
  }

  LunaBlock _headerTile(String key, String? value) {
    return LunaBlock(
      title: key.toString(),
      body: [TextSpan(text: value.toString())],
      trailing: LunaIconButton(
        icon: LunaIcons.DELETE,
        color: LunaColours.red,
        onPressed: () async {
          await HeaderUtility().deleteHeader(
            context,
            headers: widget.indexer!.headers,
            key: key,
          );
          if (mounted) setState(() {});
        },
      ),
    );
  }
}
