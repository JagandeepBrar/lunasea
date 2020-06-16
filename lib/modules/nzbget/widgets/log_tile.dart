import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/nzbget.dart';

class NZBGetLogTile extends StatelessWidget {
    final NZBGetLogData data;

    NZBGetLogTile({
        @required this.data,
    });

    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle(text: data.text),
        subtitle: LSSubtitle(text: data.timestamp),
        trailing: LSIconButton(icon: Icons.arrow_forward_ios),
        onTap: () async => GlobalDialogs.textPreview(context, 'Log Entry', data.text),
    );
}
