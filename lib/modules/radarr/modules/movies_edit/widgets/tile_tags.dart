import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrMoviesEditTagsTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LunaText.title(text: 'Tags'),
        subtitle: LSSubtitle(text: context.watch<RadarrMoviesEditState>().tags.length == 0
            ? 'Not Set'
            : context.watch<RadarrMoviesEditState>().tags.map((e) => e.label).join(', ')),
        trailing: LSIconButton(icon: Icons.arrow_forward_ios),
        onTap: () async => _onTap(context),
    );

    Future<void> _onTap(BuildContext context) async => await RadarrDialogs.setEditTags(context);
}
