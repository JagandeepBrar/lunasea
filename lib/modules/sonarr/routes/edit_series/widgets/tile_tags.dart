import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrSeriesEditTagsTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle(text: 'Tags'),
        subtitle: LSSubtitle(text: context.watch<SonarrSeriesEditState>().tags.length == 0
            ? 'Not Set'
            : context.watch<SonarrSeriesEditState>().tags.map((e) => e.label).join(', ')),
        trailing: LSIconButton(icon: Icons.arrow_forward_ios_rounded),
        onTap: () async => _onTap(context),
    );

    Future<void> _onTap(BuildContext context) async => await SonarrDialogs.setEditTags(context);
}
