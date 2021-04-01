import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/nzbget.dart';

class NZBGetLogTile extends StatelessWidget {
    final NZBGetLogData data;

    NZBGetLogTile({
        @required this.data,
    });

    @override
    Widget build(BuildContext context) => LunaListTile(
        context: context,
        title: LunaText.title(text: data.text),
        subtitle: LunaText.subtitle(text: data.timestamp),
        trailing: LunaIconButton(icon: Icons.arrow_forward_ios_rounded),
        onTap: () async => LunaDialogs().textPreview(context, 'Log Entry', data.text),
    );
}
