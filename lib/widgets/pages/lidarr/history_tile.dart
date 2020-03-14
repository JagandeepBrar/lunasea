import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/widgets/ui.dart';

class LidarrHistoryTile extends StatefulWidget {
    final LidarrHistoryData entry;
    final GlobalKey<ScaffoldState> scaffoldKey;

    LidarrHistoryTile({
        @required this.entry,
        @required this.scaffoldKey,
    });

    @override
    State<LidarrHistoryTile> createState() => _State();
}

class _State extends State<LidarrHistoryTile> {
    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle(text: widget.entry.title),
        subtitle: RichText(
            text: TextSpan(
                children: widget.entry.subtitle,
            ),
        ),
        padContent: true,
    );
}
