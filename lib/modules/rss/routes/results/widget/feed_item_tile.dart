import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../core/ui/block/block.dart';
import '../../../../../core/ui/icons/icon_button.dart';
import '../../../core/types/rss_result_item_type.dart';
import '../sheets/feed_item_details.dart';

class FeedItemTile extends StatelessWidget {
  final RssResultItem item;

  const FeedItemTile({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LunaBlock(
      title: item.title,
      body: [TextSpan(text: DateFormat('MMMM dd, y - HH:mm').format(item.date!.toLocal()))],
      trailing: LunaIconButton(
        icon: Icons.link_rounded,
        onPressed: () async {
          if (await canLaunch(item.link!)) {
            await launch(item.link!);
          }
        },
      ),
      onTap: () async {
        FeedItemDetailsSheet(
          context: context,
          item: item,
        ).show(context: context);
      },
    );
  }
}
