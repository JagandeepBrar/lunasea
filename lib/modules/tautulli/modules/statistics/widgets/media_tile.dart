import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class TautulliStatisticsMediaTile extends StatelessWidget {
    final Map<String, dynamic> data;

    TautulliStatisticsMediaTile({
        Key key,
        @required this.data,
    }) : super(key: key);

    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle(text: data['title'] ?? 'Unknown Title'),
    );
}