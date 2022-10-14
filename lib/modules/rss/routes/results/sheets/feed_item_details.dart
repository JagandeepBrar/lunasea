import 'package:flutter/material.dart';
import 'package:lunasea/api/rss/models/rss_item.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/extensions/datetime.dart';
import 'package:lunasea/extensions/string/links.dart';

class FeedItemDetailsSheet extends LunaBottomModalSheet {
  BuildContext context;
  final RssItem item;

  FeedItemDetailsSheet({
    required this.context,
    required this.item,
  });

  Widget _highlightedNodes(BuildContext context) {
    List<LunaHighlightedNode> _nodes = [
      if (item.categories!.isNotEmpty)
        ...item.categories!.map((e) => LunaHighlightedNode(
            text: e.value, backgroundColor: LunaColours.blue))
    ];
    if (_nodes.isEmpty) return const SizedBox(height: 0, width: 0);
    return Padding(
      child: Wrap(
        direction: Axis.horizontal,
        spacing: LunaUI.DEFAULT_MARGIN_SIZE / 2,
        runSpacing: LunaUI.DEFAULT_MARGIN_SIZE / 2,
        children: _nodes,
      ),
      padding: LunaUI.MARGIN_H_DEFAULT_V_HALF.copyWith(top: 0),
    );
  }

  List<Widget> _itemDetails(BuildContext context) {
    return [
      LunaHeader(
        text: item.title,
        subtitle:
            "${item.publishDate!.asAge()} - ${item.publishDate!.asDateTime(showSeconds: false)}",
      ),
      _highlightedNodes(context),
      Padding(
        padding: LunaUI.MARGIN_DEFAULT_HORIZONTAL,
        child: LunaText.subtitle(
          text: item.description!.isNotEmpty
              ? "\n${item.description!}\n"
              : 'rss.NoDescriptionAvailable'.tr(),
          maxLines: 0,
          softWrap: true,
        ),
      ),
    ];
  }

  Widget _actionBar(BuildContext context) {
    return LunaBottomActionBar(
      actions: [
        LunaButton(
          type: LunaButtonType.TEXT,
          icon: Icons.link_rounded,
          text: 'rss.OpenLink'.tr(),
          onTap: _openLink,
        ),
      ],
    );
  }

  Future<void> _openLink() async {
    item.link!.openLink();
  }

  @override
  Widget builder(BuildContext context) {
    return LunaListViewModal(
      children: [
        ..._itemDetails(context),
        if (item.fields.isNotEmpty)
          LunaTableCard(content: [
            ...item.fields.entries
                .map((e) => LunaTableContent(title: e.key, body: e.value))
          ]),
      ],
      actionBar: _actionBar(context) as LunaBottomActionBar?,
    );
  }
}
