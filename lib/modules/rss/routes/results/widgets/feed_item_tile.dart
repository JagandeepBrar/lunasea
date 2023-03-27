import 'package:flutter/material.dart';
import 'package:lunasea/api/rss/models/rss_item.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/extensions/datetime.dart';
import 'package:lunasea/extensions/string/links.dart';
import 'package:lunasea/modules/rss/routes/results/sheets/feed_item_details.dart';

class FeedItemTile extends StatelessWidget {
  final RssItem item;

  const FeedItemTile({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LunaBlock(
      backgroundColor: item.isRecent
          ? LunaColours.accent.withAlpha(45)
          : LunaColours.secondary,
      title: item.title,
      body: [
        TextSpan(
          text:
              "${item.publishDate!.asAge()} - ${item.publishDate!.asDateTime(showSeconds: false)}",
        ),
        if (item.categories!.isNotEmpty)
          ...item.categories!.map((e) => TextSpan(
              text: e.value, style: const TextStyle(color: LunaColours.blue)))
      ],
      trailing: LunaIconButton(
        icon: Icons.link_rounded,
        onPressed: () async {
          item.link!.openLink();
        },
      ),
      onTap: () async {
        FeedItemDetailsSheet(
          context: context,
          item: item,
        ).show();
      },
    );
  }
}
