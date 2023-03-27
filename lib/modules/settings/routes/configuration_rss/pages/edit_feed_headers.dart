import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/database/models/rss.dart';
import 'package:lunasea/modules/settings.dart';
import 'package:lunasea/widgets/pages/invalid_route.dart';

class ConfigurationRssEditFeedHeadersRoute extends StatefulWidget {
  final int id;

  const ConfigurationRssEditFeedHeadersRoute({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<ConfigurationRssEditFeedHeadersRoute> createState() => _State();
}

class _State extends State<ConfigurationRssEditFeedHeadersRoute>
    with LunaScrollControllerMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  LunaRss? _feed;

  @override
  Widget build(BuildContext context) {
    if (widget.id < 0 || !LunaBox.rss.contains(widget.id)) {
      return InvalidRoutePage(
        title: 'Custom Headers',
        message: 'Indexer Not Found',
      );
    }

    return LunaScaffold(
      scaffoldKey: _scaffoldKey,
      appBar: _appBar() as PreferredSizeWidget?,
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
          onTap: () async => HeaderUtility().addHeader(context,
              headers: _feed!.headers, item: _feed),
        ),
      ],
    );
  }

  Widget _body() {
    return LunaBox.rss.listenableBuilder(
      selectKeys: [widget.id],
      builder: (context, _) {
        if (!LunaBox.rss.contains(widget.id)) return Container();
        _feed = LunaBox.rss.read(widget.id);
        return LunaListView(
          controller: scrollController,
          children: [
            if (_feed!.headers.isEmpty)
              LunaMessage.inList(text: 'No Headers Added'),
            ..._list(),
          ],
        );
      },
    );
  }

  List<Widget> _list() {
    final headers = _feed!.headers.cast<String, dynamic>();
    List<String> _sortedKeys = headers.keys.toList()..sort();
    return _sortedKeys
        .map<LunaBlock>((key) => _headerBlock(key, headers[key]))
        .toList();
  }

  LunaBlock _headerBlock(String key, String? value) {
    return LunaBlock(
      title: key.toString(),
      body: [TextSpan(text: value.toString())],
      trailing: LunaIconButton(
        icon: LunaIcons.DELETE,
        color: LunaColours.red,
        onPressed: () async => HeaderUtility().deleteHeader(
          context,
          headers: _feed!.headers,
          key: key,
          item: _feed,
        ),
      ),
    );
  }
}
