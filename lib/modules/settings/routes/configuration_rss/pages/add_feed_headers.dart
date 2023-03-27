import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/database/models/rss.dart';
import 'package:lunasea/modules/settings.dart';
import 'package:lunasea/widgets/pages/invalid_route.dart';

class ConfigurationRssAddFeedHeadersRoute extends StatefulWidget {
  final LunaRss? feed;

  const ConfigurationRssAddFeedHeadersRoute({
    Key? key,
    required this.feed,
  }) : super(key: key);

  @override
  State<ConfigurationRssAddFeedHeadersRoute> createState() => _State();
}

class _State extends State<ConfigurationRssAddFeedHeadersRoute>
    with LunaScrollControllerMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    if (widget.feed == null) {
      return InvalidRoutePage(
        title: 'Custom Headers',
        message: 'Feed Not Found',
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
                .addHeader(context, headers: widget.feed!.headers);
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
        if (widget.feed!.headers.isEmpty)
          LunaMessage.inList(text: 'No Headers Added'),
        ..._list(),
      ],
    );
  }

  List<Widget> _list() {
    final headers = widget.feed!.headers.cast<String, dynamic>();
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
            headers: widget.feed!.headers,
            key: key,
          );
          if (mounted) setState(() {});
        },
      ),
    );
  }
}
